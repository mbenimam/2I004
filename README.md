# Computer architecture, from logic gates to a CPU

This repository is my work for the computer architecture course (2I004) at Sorbonne University. It follows one idea from the ground up: a computer is a lot of very simple switches, arranged in layers, and each layer makes the next one possible. I built the circuits in Logisim, wrote the programs in MIPS assembly, and kept the reports that explain each step.

| | |
| --- | --- |
| **What** | Logic circuits (multiplexers, adders, an ALU, registers, RAM) that grow into a single-bus CPU datapath, plus MIPS assembly programs and the reports for each step. |
| **For** | Anyone who wants to see how a processor is built from gates, or who is taking the same course. |
| **Stack** | Logisim-evolution 5.0.0 for the circuits, MARS 4.5 for MIPS assembly. |
| **Verified** | Both adders and the comparator match arithmetic on every input (512 and 256 rows). Every program assembles in MARS. |
| **Start here** | [The path from a gate to a CPU](#the-path-from-a-gate-to-a-cpu) |

## The path from a gate to a CPU

Every circuit in this repository is a step on one path. Each step uses the one before it.

1. **Multiplexers.** A multiplexer picks one input out of several, using a select signal. Build a 2-to-1 from gates, then chain three of them into a 4-to-1. The file `circuits/multiplexers-and-coffee-machine.circ` also holds a small control circuit for a coffee machine, a good exercise in turning a rule into logic.
2. **Adders and subtraction.** A **full adder** adds three bits and gives a sum and a carry. Chain four of them and you get a 4-bit adder. Subtraction is addition of the negated second number, so one circuit can do both, and a single select signal chooses which. The file is `circuits/adder-subtractor-4bit.circ`.
3. **The ALU.** The **arithmetic logic unit** is the part of a processor that does the calculations. Here it combines the add/subtract unit with a bit-by-bit comparator, and it produces flags that say what happened: carry, overflow, zero and sign. A single select signal, `SELECTEUR`, chooses between addition and subtraction; XOR gates on the second input turn it into its negation when subtracting. The file is `circuits/alu-and-comparator.circ`. See [Known issues](#known-issues) for its current state.

![The add/subtract unit: SELECTEUR, XOR gates on B, and the flags CF, OV, ZF and SF](images/FullAdder.png)

*A Logisim view of the add/subtract unit. The screenshot is from the course; the circuit file is in `circuits/`.*
4. **Registers and RAM.** A **register** stores a few bits and changes only when its write-enable signal and the clock both say so. **RAM** is a bigger array of those storage cells, addressed by a number. The file is `circuits/register-datapath-and-ram.circ`.
5. **The CPU datapath.** The last circuit connects everything through one shared wire, the **bus**. Registers, the ALU and memory take turns driving that wire. A control signal opens exactly one source at a time, so two sources never fight over it. The file is `circuits/single-bus-cpu-datapath.circ`.

![The single-bus datapath in Logisim: bus X, bus Y, a bank of four registers, an adder, and memory](images/MipsModel.png)

*The single-bus datapath as drawn in Logisim: two buses, a bank of four registers, the adder, and RAM with its own address bus.*

## Words used in this README

- **Logic gate**: a circuit with one or two inputs and one output, such as AND, OR, NOT and XOR.
- **Multiplexer**: a circuit that copies one of its inputs to its output, chosen by a select signal.
- **Full adder**: a circuit that adds three bits (two numbers' bits plus a carry in) and gives a sum bit and a carry out.
- **Carry**: the extra bit that moves to the next column when a sum does not fit in one bit.
- **Two's complement**: the usual way to write negative numbers in binary, so that subtraction is addition.
- **Flag**: a single bit set by an operation to report something about its result. Here: CF (carry), OV (overflow), ZF (zero), SF (sign).
- **Register**: a small, fast storage cell for a few bits, usually the value a CPU is working on.
- **RAM**: random-access memory, a large array of cells, each with an address.
- **Bus**: a shared set of wires that several parts of a circuit use in turn.
- **Datapath**: the part of a CPU that moves and transforms data, as opposed to the control that decides what happens.
- **MIPS**: the instruction set (the list of operations a processor understands) used in the course.
- **Data segment**: the part of a MIPS program that holds constants and variables in memory.
- **Syscall**: a request from a program to the simulator, such as printing a number or ending the program.

## What is in the repository

```
circuits/     the five Logisim circuits, one per step above
reports/      the written report for each step, in French, with the reasoning
programs/     MIPS assembly programs, grouped by theme (see below)
images/       the diagrams used in this README
```

Programs by theme:

| Folder | What it covers |
| --- | --- |
| `programs/arithmetic/` | MIPS arithmetic and immediate values, including division |
| `programs/data-segment/` | Declaring bytes, words and strings in memory |
| `programs/loops-and-arrays/` | Loops with counters, string printing, and searching a table |
| `programs/numbers-and-characters/` | Digits and characters, with loops that print numbers |
| `programs/strings/` | Working with strings and comparing characters |
| `programs/bit-extraction/` | Reading the bits of a number, one at a time |

## Running it

You need Java, plus two free tools:

- **Logisim-evolution 5.0.0**: download `logisim-evolution-5.0.0-all.jar` from its [GitHub releases](https://github.com/logisim-evolution/logisim-evolution/releases).
- **MARS 4.5**: the MIPS simulator. On Arch it is the AUR package `mars-mips`; the jar is `Mars4_5.jar`.

Open a circuit in its editor:

```sh
java -jar logisim-evolution.jar circuits/adder-subtractor-4bit.circ
```

Run a program without the window, and print its output:

```sh
java -jar Mars4_5.jar nc programs/arithmetic/exo1.s
```

To print a truth table of a circuit without the window (Logisim's text mode), the circuit has to be both the file's first circuit and its named main circuit. The adder and comparator checks below were done this way, on scratch copies, so the files in this repository are untouched.

## How it was checked

I did not trust the circuits by looking at them, so I ran them.

- **Adders.** The 4-bit adder, in `circuits/adder-subtractor-4bit.circ`, was simulated on all 512 combinations of its inputs. Every sum and carry matches ordinary binary addition. The add/sub circuit matched addition when its select is 0, and matched `b − c` (mod 16) with the borrow when its select is 1, on all 512 rows.
- **Comparator.** The 4-bit comparator, inside the ALU file, was simulated on all 256 pairs of 4-bit numbers. Its three outputs (A > B, A < B, A = B) match arithmetic on every row.
- **Programs.** All 23 programs assemble in MARS with no errors. Running them tells a different story; see below.
- **Loading.** All five circuits open and simulate in Logisim-evolution 5.0.0.

## Known issues

I would rather list these than hide them.

- **The ALU file does not simulate.** Every output of `alu-and-comparator.circ` comes out undefined (`U`) or in error (`E`) in Logisim's text mode, on every input. Its adder and comparator blocks work on their own, so the problem is in the ALU's own wiring. It needs a look in the Logisim window.
- **Two bit-extraction programs crash.** `programs/bit-extraction/Exo1Q2.s` and `Exo1Q3.s` stop at line 25, the store `sb $6, 0($1)`, with *address out of range 0x00000008*. The pointer `$1` is set correctly at line 14, so it goes wrong later in the loop. I have not yet traced where.
- **Programs are checked for assembly, not for output.** I have not yet compared the printed output of each program with what its report says it should print.
- **Reports are mostly in French.** The course is taught in French, so the reports are too. This README is in English.

## Where this is going

The next step is the one the course builds towards: running a real MIPS program on the datapath, one instruction at a time. That needs the ALU fixed first.
