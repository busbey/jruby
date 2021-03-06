package org.jruby.truffle.interop;

/*
 * Copyright (c) 2013, 2016 Oracle and/or its affiliates. All rights reserved. This
 * code is released under a tri EPL/GPL/LGPL license. You can use it,
 * redistribute it and/or modify it under the terms of the:
 *
 * Eclipse Public License version 1.0
 * GNU General Public License version 2
 * GNU Lesser General Public License version 2.1
 */
import com.oracle.truffle.api.CompilerDirectives;
import com.oracle.truffle.api.dsl.Cached;
import com.oracle.truffle.api.dsl.NodeChild;
import com.oracle.truffle.api.dsl.NodeChildren;
import com.oracle.truffle.api.dsl.Specialization;
import com.oracle.truffle.api.frame.VirtualFrame;
import com.oracle.truffle.api.object.DynamicObject;
import org.jruby.truffle.language.RubyNode;
import org.jruby.truffle.language.dispatch.CallDispatchHeadNode;
import org.jruby.truffle.language.dispatch.DispatchHeadNodeFactory;
import org.jruby.truffle.language.dispatch.DoesRespondDispatchHeadNode;
import org.jruby.truffle.language.objects.WriteObjectFieldNode;
import org.jruby.truffle.language.objects.WriteObjectFieldNodeGen;

@NodeChildren({
        @NodeChild("receiver"),
        @NodeChild("name"),
        @NodeChild("stringName"),
        @NodeChild("startsAt"),
        @NodeChild("value")
})
abstract class ForeignWriteStringCachedHelperNode extends RubyNode {

    @Child
    private DoesRespondDispatchHeadNode definedNode;
    @Child
    private DoesRespondDispatchHeadNode indexDefinedNode;
    @Child
    private CallDispatchHeadNode callNode;

    protected final static String INDEX_METHOD_NAME = "[]=";

    public abstract Object executeStringCachedHelper(VirtualFrame frame, DynamicObject receiver, Object name,
                                                     String stringName, boolean startsAt, Object value);

    @Specialization(guards = "startsAt(startsAt)")
    public Object readInstanceVariable(
            DynamicObject receiver,
            Object name,
            String stringName,
            boolean startsAt,
            Object value,
            @Cached("createWriteObjectFieldNode(stringName)") WriteObjectFieldNode writeObjectFieldNode) {
        writeObjectFieldNode.execute(receiver, value);
        return value;
    }

    protected boolean startsAt(boolean startsAt) {
        return startsAt;
    }

    protected WriteObjectFieldNode createWriteObjectFieldNode(String name) {
        return WriteObjectFieldNodeGen.create(name);
    }

    @Specialization(
            guards = {
                    "notStartsAt(startsAt)",
                    "methodDefined(frame, receiver, writeMethodName, getDefinedNode())"
            }
    )
    public Object callMethod(
            VirtualFrame frame,
            DynamicObject receiver,
            Object name,
            String stringName,
            boolean startsAt,
            Object value,
            @Cached("createWriteMethodName(stringName)") String writeMethodName) {
        return getCallNode().call(frame, receiver, writeMethodName, null, value);
    }

    protected String createWriteMethodName(String name) {
        return name + "=";
    }

    @Specialization(
            guards = {
                    "notStartsAt(startsAt)",
                    "!methodDefined(frame, receiver, writeMethodName, getDefinedNode())",
                    "methodDefined(frame, receiver, INDEX_METHOD_NAME, getIndexDefinedNode())"
            }
    )
    public Object index(
            VirtualFrame frame,
            DynamicObject receiver,
            Object name,
            String stringName,
            boolean startsAt,
            Object value,
            @Cached("createWriteMethodName(stringName)") String writeMethodName) {
        return getCallNode().call(frame, receiver, "[]", null, name, value);
    }

    protected boolean notStartsAt(boolean startsAt) {
        return !startsAt;
    }

    protected DoesRespondDispatchHeadNode getDefinedNode() {
        if (definedNode == null) {
            CompilerDirectives.transferToInterpreter();
            definedNode = insert(new DoesRespondDispatchHeadNode(getContext(), true));
        }

        return definedNode;
    }

    protected DoesRespondDispatchHeadNode getIndexDefinedNode() {
        if (indexDefinedNode == null) {
            CompilerDirectives.transferToInterpreter();
            indexDefinedNode = insert(new DoesRespondDispatchHeadNode(getContext(), true));
        }

        return indexDefinedNode;
    }

    protected boolean methodDefined(VirtualFrame frame, DynamicObject receiver, String stringName,
                                    DoesRespondDispatchHeadNode definedNode) {
        return definedNode.doesRespondTo(frame, stringName, receiver);
    }

    protected CallDispatchHeadNode getCallNode() {
        if (callNode == null) {
            CompilerDirectives.transferToInterpreter();
            callNode = insert(DispatchHeadNodeFactory.createMethodCall(getContext(), true));
        }

        return callNode;
    }

}
