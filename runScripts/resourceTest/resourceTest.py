from gem5.components.boards.simple_board import SimpleBoard
from gem5.components.processors.simple_processor import SimpleProcessor
from gem5.components.cachehierarchies.ruby.mesi_two_level_cache_hierarchy import (
    MESITwoLevelCacheHierarchy
)
from gem5.components.memory.single_channel import SingleChannelDDR4_2400
from gem5.components.processors.cpu_types import CPUTypes
from gem5.isas import ISA
from gem5.resources.resource import obtain_resource,BinaryResource
from gem5.simulate.simulator import Simulator

cache_hierarchy = MESITwoLevelCacheHierarchy(
    l1d_size="16KiB",
    l1d_assoc=8,
    l1i_size="16KiB",
    l1i_assoc=8,
    l2_size="256KiB",
    l2_assoc=16,
    num_l2_banks=1
)

memory = SingleChannelDDR4_2400() # Default 'size="8GB"'

processor = SimpleProcessor(
    cpu_type=CPUTypes.TIMING,
    num_cores=1,
    isa=ISA.X86
)

board = SimpleBoard(
    clk_freq="3GHz",
    processor=processor,
    memory=memory,
    cache_hierarchy=cache_hierarchy
)

'''
# Add binary to the board
getting_started_suite = obtain_resource("x86-getting-started-benchmark-suite")
for workload in getting_started_suite:
    print(f"Workload ID: {workload.get_id()}")
    print(f"Workload Version: {workload.get_resource_version()}")
    print("=========================")

npb_is_workload = list(getting_started_suite.with_input_group("is"))[0]
print(f"Workload ID: {npb_is_workload.get_id()}")

# Doesn't work with gem5 v25
board.set_se_binary_workload(npb_is_workload)
'''

'''binary = BinaryResource(
    local_path="pattern"
)'''

binary = obtain_resource("x86-pattern-print", resource_version="1.0.0")

board.set_se_binary_workload(binary)

simulator = Simulator(
    board=board
)

simulator.run()