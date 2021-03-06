# Copyright (c) 2014, 2016 Oracle and/or its affiliates. All rights reserved. This
# code is released under a tri EPL/GPL/LGPL license. You can use it,
# redistribute it and/or modify it under the terms of the:
#
# Eclipse Public License version 1.0
# GNU General Public License version 2
# GNU Lesser General Public License version 2.1

module Truffle
  # Utility method for commenting out part of Rubinius's implementation and detailing why.  It helps clearly
  # demarcate things we want to omit from things Rubinius has left commented out and as such, should help compare
  # diffs when upgrading Rubinius core files.
  def self.omit(reason)
  end
end

Truffle::Boot.require_core 'core/pre'

# Load Rubinius API

Truffle::Boot.require_core 'core/rubinius/api/compat/type'
Truffle::Boot.require_core 'core/rubinius/api/kernel/common/thread'
Truffle::Boot.require_core 'core/rubinius/api/kernel/common/type'

# Patch rubinius-core-api to make it work for us

Truffle::Boot.require_core 'core/rubinius/api/shims/lookuptable'
Truffle::Boot.require_core 'core/rubinius/api/shims/rubinius'
Truffle::Boot.require_core 'core/rubinius/api/shims/thread'
Truffle::Boot.require_core 'core/rubinius/api/shims/tuple'
Truffle::Boot.require_core 'core/rubinius/api/shims/metrics'
Truffle::Boot.require_core 'core/rubinius/api/shims/hash'

# Rubinius primitives written in Ruby

Truffle::Boot.require_core 'core/rubinius/primitives'

# Load alpha.rb

Truffle::Boot.require_core 'core/rubinius/alpha'

# Load bootstrap (ordered according to Rubinius' load_order.txt)

Truffle::Boot.require_core 'core/rubinius/bootstrap/atomic'
Truffle::Boot.require_core 'core/rubinius/bootstrap/basic_object'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/logger'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/alias'
Truffle::Boot.require_core 'core/rubinius/bootstrap/mirror'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/array_mirror'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/array'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/atomic'
Truffle::Boot.require_core 'core/rubinius/bootstrap/bignum'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/block_environment'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/byte_array'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/call_site'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/call_custom_cache'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/channel'
Truffle::Boot.require_core 'core/rubinius/api/shims/channel'
Truffle::Boot.require_core 'core/rubinius/bootstrap/character'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/class'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/compact_lookup_table'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/compiled_code'
Truffle::Boot.require_core 'core/rubinius/bootstrap/configuration'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/constant_cache'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/constant_scope'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/constant_table'
Truffle::Boot.require_core 'core/rubinius/bootstrap/dir'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/encoding'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/exception'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/executable'
Truffle::Boot.require_core 'core/rubinius/bootstrap/false'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/fixnum'
Truffle::Boot.require_core 'core/rubinius/bootstrap/gc'
Truffle::Boot.require_core 'core/rubinius/bootstrap/io'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/iseq'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/jit'
Truffle::Boot.require_core 'core/rubinius/bootstrap/kernel'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/lookup_table'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/method_table'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/mono_inline_cache'
Truffle::Boot.require_core 'core/rubinius/bootstrap/nil'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/proc'
Truffle::Boot.require_core 'core/rubinius/bootstrap/process'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/poly_inline_cache'
Truffle::Boot.require_core 'core/rubinius/bootstrap/regexp'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/respond_to_cache'
Truffle::Boot.require_core 'core/rubinius/bootstrap/rubinius'
Truffle::Boot.require_core 'core/rubinius/bootstrap/stat'
Truffle::Boot.require_core 'core/rubinius/bootstrap/string'
Truffle::Boot.require_core 'core/rubinius/bootstrap/symbol'
Truffle::Boot.require_core 'core/rubinius/bootstrap/thread'
Truffle::Boot.require_core 'core/rubinius/api/shims/thread_bootstrap'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/thunk'
Truffle::Boot.require_core 'core/rubinius/bootstrap/time'
Truffle::Boot.require_core 'core/rubinius/bootstrap/true'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/tuple'
Truffle::Boot.require_core 'core/rubinius/bootstrap/type'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/variable_scope'
#Truffle::Boot.require_core 'core/rubinius/bootstrap/vm'
Truffle::Boot.require_core 'core/rubinius/bootstrap/weakref'

# Load platform (ordered according to Rubinius' load_order.txt)

Truffle::Boot.require_core 'core/library'

Truffle::Boot.require_core 'core/rubinius/platform/ffi'
#Truffle::Boot.require_core 'core/rubinius/platform/enum'
#Truffle::Boot.require_core 'core/rubinius/platform/library'
Truffle::Boot.require_core 'core/rubinius/platform/pointer_accessors'
Truffle::Boot.require_core 'core/rubinius/platform/pointer'
Truffle::Boot.require_core 'core/rubinius/platform/env'
Truffle::Boot.require_core 'core/rubinius/platform/file'
#Truffle::Boot.require_core 'core/rubinius/platform/math'
#Truffle::Boot.require_core 'core/rubinius/platform/posix'
Truffle::Boot.require_core 'core/rubinius/platform/struct'
#Truffle::Boot.require_core 'core/rubinius/platform/union'

# Load common (ordered according to Rubinius' load_order.txt)

#Truffle::Boot.require_core 'core/rubinius/common/basic_object'
Truffle::Boot.require_core 'core/rubinius/common/string_mirror'
Truffle::Boot.require_core 'core/rubinius/api/shims/string_mirror'
#Truffle::Boot.require_core 'core/rubinius/common/class'
#Truffle::Boot.require_core 'core/rubinius/common/autoload'
Truffle::Boot.require_core 'core/rubinius/common/module'
Truffle::Boot.require_core 'core/rubinius/api/shims/module'
#Truffle::Boot.require_core 'core/rubinius/common/binding'
Truffle::Boot.require_core 'core/rubinius/common/proc'
Truffle::Boot.require_core 'core/rubinius/common/enumerable_helper'
Truffle::Boot.require_core 'core/rubinius/common/enumerable'
Truffle::Boot.require_core 'core/rubinius/common/enumerator'
Truffle::Boot.require_core 'core/rubinius/common/argf'
Truffle::Boot.require_core 'core/rubinius/api/shims/argf'
#Truffle::Boot.require_core 'core/rubinius/common/tuple'
Truffle::Boot.require_core 'core/rubinius/common/exception'
Truffle::Boot.require_core 'core/rubinius/api/shims/exception'
Truffle::Boot.require_core 'core/rubinius/common/undefined'
Truffle::Boot.require_core 'core/rubinius/common/type'
Truffle::Boot.require_core 'core/rubinius/common/hash'
Truffle::Boot.require_core 'core/hash' # Our changes
#Truffle::Boot.require_core 'core/rubinius/common/hash_hamt'
Truffle::Boot.require_core 'core/rubinius/common/array'
Truffle::Boot.require_core 'core/rubinius/api/shims/array'
Truffle::Boot.require_core 'core/rubinius/common/kernel'
Truffle::Boot.require_core 'core/rubinius/api/shims/kernel'
Truffle::Boot.require_core 'core/rubinius/common/identity_map'
#Truffle::Boot.require_core 'core/rubinius/common/loaded_features'
#Truffle::Boot.require_core 'core/rubinius/common/global'
#Truffle::Boot.require_core 'core/rubinius/common/backtrace'
Truffle::Boot.require_core 'core/rubinius/common/comparable'
Truffle::Boot.require_core 'core/rubinius/common/numeric_mirror'
Truffle::Boot.require_core 'core/rubinius/common/numeric'
Truffle::Boot.require_core 'core/rubinius/common/ctype'
Truffle::Boot.require_core 'core/rubinius/common/integer'
Truffle::Boot.require_core 'core/rubinius/common/bignum'
#Truffle::Boot.require_core 'core/rubinius/common/block_environment'
#Truffle::Boot.require_core 'core/rubinius/common/byte_array'
Truffle::Boot.require_core 'core/rubinius/common/channel'
#Truffle::Boot.require_core 'core/rubinius/common/executable'
#Truffle::Boot.require_core 'core/rubinius/common/constant_scope'
#Truffle::Boot.require_core 'core/rubinius/common/hook'
#Truffle::Boot.require_core 'core/rubinius/common/code_loader'
#Truffle::Boot.require_core 'core/rubinius/common/compiled_code'
#Truffle::Boot.require_core 'core/rubinius/common/continuation'
#Truffle::Boot.require_core 'core/rubinius/common/delegated_method'
Truffle::Boot.require_core 'core/rubinius/common/fixnum'
Truffle::Boot.require_core 'core/rubinius/api/shims/fixnum'
Truffle::Boot.require_core 'core/rubinius/common/lru_cache'
Truffle::Boot.require_core 'core/rubinius/api/shims/encoding'
Truffle::Boot.require_core 'core/rubinius/common/encoding'
Truffle::Boot.require_core 'core/rubinius/common/env'
ENV = Rubinius::EnvironmentVariables.new
Truffle::Boot.require_core 'core/rubinius/common/errno'
#Truffle::Boot.require_core 'core/rubinius/common/eval'
Truffle::Boot.require_core 'core/rubinius/common/false'
#Truffle::Boot.require_core 'core/rubinius/common/fiber'
Truffle::Boot.require_core 'core/rubinius/common/io'
Truffle::Boot.require_core 'core/rubinius/api/shims/io'
Truffle::Boot.require_core 'core/rubinius/common/file'
Truffle::Boot.require_core 'core/rubinius/common/dir'
Truffle::Boot.require_core 'core/rubinius/common/dir_glob'
Truffle::Boot.require_core 'core/rubinius/common/file_test'
Truffle::Boot.require_core 'core/rubinius/common/stat'
Truffle::Boot.require_core 'core/rubinius/api/shims/stat'
Truffle::Boot.require_core 'core/rubinius/common/float'
Truffle::Boot.require_core 'core/rubinius/common/immediate'
#Truffle::Boot.require_core 'core/rubinius/common/location'
#Truffle::Boot.require_core 'core/rubinius/common/lookup_table'
Truffle::Boot.require_core 'core/rubinius/common/main'
Truffle::Boot.require_core 'core/rubinius/common/marshal'
Truffle::Boot.require_core 'core/rubinius/api/shims/marshal'
#Truffle::Boot.require_core 'core/rubinius/common/math'
#Truffle::Boot.require_core 'core/rubinius/common/method'
#Truffle::Boot.require_core 'core/rubinius/common/method_equality'
#Truffle::Boot.require_core 'core/rubinius/common/method_table'
#Truffle::Boot.require_core 'core/rubinius/common/missing_method'
#Truffle::Boot.require_core 'core/rubinius/common/native_method'
Truffle::Boot.require_core 'core/rubinius/common/nil'
Truffle::Boot.require_core 'core/rubinius/common/object_space'
Truffle::Boot.require_core 'core/rubinius/common/string'
Truffle::Boot.require_core 'core/rubinius/common/range_mirror'
Truffle::Boot.require_core 'core/rubinius/api/shims/range_mirror'
Truffle::Boot.require_core 'core/rubinius/common/range'
Truffle::Boot.require_core 'core/rubinius/api/shims/range'
Truffle::Boot.require_core 'core/rubinius/common/struct'
Truffle::Boot.require_core 'core/rubinius/common/process'
Truffle::Boot.require_core 'core/rubinius/common/process_mirror'
Truffle::Boot.require_core 'core/rubinius/common/random'
Truffle::Boot.require_core 'core/rubinius/common/regexp'
Truffle::Boot.require_core 'core/rubinius/common/signal'
Truffle::Boot.require_core 'core/rubinius/common/splitter'
#Truffle::Boot.require_core 'core/rubinius/common/sprinter'
Truffle::Boot.require_core 'core/rubinius/common/symbol'
Truffle::Boot.require_core 'core/rubinius/common/mutex'
Truffle::Boot.require_core 'core/rubinius/common/thread'
#Truffle::Boot.require_core 'core/rubinius/common/thread_group'
Truffle::Boot.require_core 'core/rubinius/common/throw_catch'
Truffle::Boot.require_core 'core/rubinius/common/time'
Truffle::Boot.require_core 'core/rubinius/api/shims/time'
Truffle::Boot.require_core 'core/rubinius/common/true'
#Truffle::Boot.require_core 'core/rubinius/common/variable_scope'
#Truffle::Boot.require_core 'core/rubinius/common/capi'
Truffle::Boot.require_core 'core/rubinius/common/rational'
Truffle::Boot.require_core 'core/rubinius/common/rationalizer'
Truffle::Boot.require_core 'core/rubinius/common/complex'
Truffle::Boot.require_core 'core/rubinius/common/complexifier'
Truffle::Boot.require_core 'core/rubinius/common/gc'

# Load delta (ordered according to Rubinius' load_order.txt)

#Truffle::Boot.require_core 'core/rubinius/delta/ctype'
#Truffle::Boot.require_core 'core/rubinius/delta/exception'
Truffle::Boot.require_core 'core/rubinius/delta/file'
#Truffle::Boot.require_core 'core/rubinius/delta/rubinius'
#Truffle::Boot.require_core 'core/rubinius/delta/runtime'
Truffle::Boot.require_core 'core/rubinius/delta/module'
Truffle::Boot.require_core 'core/rubinius/delta/class'
Truffle::Boot.require_core 'core/rubinius/delta/file_test'
Truffle::Boot.require_core 'core/rubinius/delta/kernel'
#Truffle::Boot.require_core 'core/rubinius/delta/math'
#Truffle::Boot.require_core 'core/rubinius/delta/options'
#Truffle::Boot.require_core 'core/rubinius/delta/stats'
#Truffle::Boot.require_core 'core/rubinius/delta/signal'
Truffle::Boot.require_core 'core/rubinius/delta/struct'
#Truffle::Boot.require_core 'core/rubinius/delta/thread'
#Truffle::Boot.require_core 'core/rubinius/delta/code_loader'
#Truffle::Boot.require_core 'core/rubinius/delta/fsevent'
#Truffle::Boot.require_core 'core/rubinius/delta/console'
Truffle::Boot.require_core 'core/rubinius/delta/ffi'
#Truffle::Boot.require_core 'core/rubinius/delta/ruby_constants'
#Truffle::Boot.require_core 'core/rubinius/delta/pack'
#Truffle::Boot.require_core 'core/rubinius/delta/metrics'

# Load JRuby+Truffle classes

Truffle::Boot.require_core 'core/array'
Truffle::Boot.require_core 'core/binding'
Truffle::Boot.require_core 'core/fixnum'
Truffle::Boot.require_core 'core/float'
Truffle::Boot.require_core 'core/kernel'
Truffle::Boot.require_core 'core/math'
Truffle::Boot.require_core 'core/method'
Truffle::Boot.require_core 'core/module'
Truffle::Boot.require_core 'core/signal'
Truffle::Boot.require_core 'core/string'
Truffle::Boot.require_core 'core/thread'
Truffle::Boot.require_core 'core/unbound_method'
Truffle::Boot.require_core 'core/type'

# Dirty fixes we'd like to get rid of soon
Truffle::Boot.require_core 'core/shims'

# Load JRuby+Truffle specific classes

Truffle::Boot.require_core 'core/truffle/attachments'
Truffle::Boot.require_core 'core/truffle/debug'
Truffle::Boot.require_core 'core/truffle/truffle'
Truffle::Boot.require_core 'core/truffle/interop'

# Start running Ruby code outside classes

Truffle::Boot.require_core 'core/config'
Truffle::Boot.require_core 'core/main'

Truffle::Boot.require_core 'core/post'
