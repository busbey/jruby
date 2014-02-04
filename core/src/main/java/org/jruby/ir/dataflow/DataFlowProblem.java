package org.jruby.ir.dataflow;

import java.util.BitSet;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.jruby.ir.IRScope;
import org.jruby.ir.representations.BasicBlock;

public abstract class DataFlowProblem<T extends DataFlowProblem<T, U>, U extends FlowGraphNode<T, U>> {
/* -------------- Public fields and methods below ---------------- */
    public enum DF_Direction { FORWARD, BACKWARD, BIDIRECTIONAL };

    public final DF_Direction direction;

    public DataFlowProblem(DF_Direction direction) {
        this.direction = direction;
    }

// ------- Abstract methods without a default implementation -------
    abstract public U buildFlowGraphNode(BasicBlock bb);
    abstract public String getName();

// ------- Default implementation methods below -------
    /** Are there are available data flow facts to run this problem? SSS FIXME: Silly optimization? */
    public boolean isEmpty() {
        return false;
    }

    public DF_Direction getFlowDirection() {
        return direction;
    }

    public void setup(IRScope scope) {
        this.scope = scope;
        buildFlowGraph();
    }

    public IRScope getScope() {
        return scope;
    }

    /* Compute Meet Over All Paths solution for this dataflow problem on the input CFG.
     * This implements a standard worklist algorithm. */
    public void compute_MOP_Solution() {
        if (isEmpty()) return;  // Don't bother to compute soln if we have no facts available.

        // 1. Initialize work list based on flow direction to make processing efficient!
        LinkedList<U> workList = generateWorkList();

        // 2. Initialize a bitset with a flag set for all basic blocks
        int numNodes = scope.cfg().getMaxNodeID();
        BitSet bbSet = new BitSet(1+numNodes);
        bbSet.flip(0, numNodes); // set all bits from default of 0 to 1 (enebo: could we invert this in algo?)

        // 3. Iteratively compute data flow info
        while (!workList.isEmpty()) {
            workList.removeFirst().computeDataFlowInfo(workList, bbSet);
        }
    }

    /**
     * Generate an ordered list of flow graph nodes in a forward or backward order depending
     * on direction.
     */
    protected LinkedList<U> generateWorkList() {
        LinkedList<U> wl = new LinkedList<U>();
        Iterator<BasicBlock> it = direction == DF_Direction.FORWARD ?
                scope.cfg().getReversePostOrderTraverser() : scope.cfg().getPostOrderTraverser();
 
        while (it.hasNext()) {
            wl.add(getFlowGraphNode(it.next()));
        }

        return wl;
    }

    public int getDFVarsCount() {
        return nextVariableId + 1;
    }

    public Iterable<BasicBlock> getIncomingSourcesOf(BasicBlock bb) {
        return scope.cfg().getIncomingSources(bb);
    }

    public Iterable<BasicBlock> getOutgoingDestinationsOf(BasicBlock bb) {
        return scope.cfg().getOutgoingDestinations(bb);
    }

    /* Individual analyses should override this */
    public String getDataFlowVarsForOutput() {
        return "";
    }

    @Override
    public String toString() {
        StringBuilder buf = new StringBuilder();
        buf.append("----").append(getName()).append("----\n");

        buf.append("---- Data Flow Vars: ----\n");
        buf.append(getDataFlowVarsForOutput());
        buf.append("-------------------------\n");

        for (FlowGraphNode n: flowGraphNodes) {
            buf.append("DF State for BB ").append(n.basicBlock.getID()).append(":\n").append(n.toString());
        }

        return buf.toString();
    }

    public U getFlowGraphNode(BasicBlock b) {
        return basicBlockToFlowGraph.get(b.getID());
    }

    public U getEntryNode() {
        return getFlowGraphNode(scope.cfg().getEntryBB());
    }

    public U getExitNode() {
        return getFlowGraphNode(scope.cfg().getExitBB());
    }

    public int addDataFlowVar() {
        nextVariableId++;
        return nextVariableId;
    }

/* -------------- Protected fields and methods below ---------------- */
    protected List<U> flowGraphNodes;
    protected IRScope scope;

/* -------------- Private fields and methods below ---------------- */
    private int nextVariableId = -1;
    private Map<Integer, U> basicBlockToFlowGraph;

    private void buildFlowGraph() {
        flowGraphNodes = new LinkedList<U>();
        basicBlockToFlowGraph = new HashMap<Integer, U>();

        for (BasicBlock bb: scope.cfg().getBasicBlocks()) {
            U fgNode = buildFlowGraphNode(bb);
            fgNode.init();
            fgNode.buildDataFlowVars();
            flowGraphNodes.add(fgNode);
            basicBlockToFlowGraph.put(bb.getID(), fgNode);
        }
    }
}
