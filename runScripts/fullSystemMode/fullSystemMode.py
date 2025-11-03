from gem5.components.boards.x86_board import X86Board
from gem5.components.processors.simple_processor import SimpleProcessor
from gem5.components.cachehierarchies.ruby.mesi_two_level_cache_hierarchy import (
	MESITwoLevelCacheHierarchy
)
from gem5.components.memory.single_channel import SingleChannelDDR3_1600
from gem5.components.processors.cpu_types import CPUTypes
from gem5.isas import ISA
from gem5.resources.resource import obtain_resource,BinaryResource
from gem5.simulate.simulator import Simulator
from gem5.simulate.exit_event import ExitEvent
from gem5.utils.requires import requires

import m5.debug

from gem5.components.cachehierarchies.classic.private_l1_private_l2_walk_cache_hierarchy import (
	PrivateL1PrivateL2WalkCacheHierarchy,
)

requires(
	isa_required=ISA.X86,
	#kvm_required=True,
)

cache_hierarchy = PrivateL1PrivateL2WalkCacheHierarchy(
	l1d_size="16KiB",
	l1i_size="16KiB",
	l2_size="256KiB",
)

memory = SingleChannelDDR3_1600(size="3GiB")

processor = SimpleProcessor(
	cpu_type=CPUTypes.KVM,
	#cpu_type=CPUTypes.TIMING,
	num_cores=2,
	isa=ISA.X86
)

'''for proc in processor.cores:
	proc.core.usePerf = False'''

board = X86Board(
	clk_freq="3GHz",
	processor=processor,
	memory=memory,
	cache_hierarchy=cache_hierarchy
)

workload = obtain_resource("x86-ubuntu-22.04-boot-with-systemd")
board.set_workload(workload=workload)

def exit_event_handler():
	print("Exit Event: Kernel booted")
	yield False

	print("Exit Event: Systemd initialized")
	yield False

	print("Exit Event: After run script")
	yield True

simulator = Simulator(
	board=board,
	on_exit_event={
		ExitEvent.EXIT: exit_event_handler()
	}
)

simulator.run()