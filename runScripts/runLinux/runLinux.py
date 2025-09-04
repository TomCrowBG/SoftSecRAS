from gem5.prebuilt.demo.x86_demo_board import X86DemoBoard
from gem5.resources.resource import obtain_resource
from gem5.simulate.simulator import Simulator

board = X86DemoBoard()

# Find resources on 'https://resources.gem5.org/'
board.set_workload(obtain_resource("x86-ubuntu-24.04-boot-no-systemd"))

sim = Simulator(board=board)
sim.run(20_000_000_000)