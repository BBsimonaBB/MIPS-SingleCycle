# MIPS-SingleCycle

This project represents the code support needed for implementing a Single Cycle microprocessor.  
The code is written in VHDL and is programmable on a Basys 3 board.

## Requirements

Vivado: 2016. 4 (for generating a bitstream)  
Basys 3 Digilent board (optional)

## Usage

The components are added to a Vivado project. There is also need of a constraints file that helps with the programming on the board so that all the buttons, lights and switches are recognized as expected.
The bitstream attached can be generated from Vivado or can be directly programmed on the board for starting the project.  

To be noted that the program that was uploaded on my microprocessor is written in binary code, after being translated from ASSEMBLY. 
Here is the code in assembly and alos its translation to binary code  
![image](https://user-images.githubusercontent.com/69772634/205271816-0df286e5-086b-4fb1-bbbc-2b17c9f1de4a.png)

My program does a multiplication via multiple addings and checks if the result is the one expected. If yes, the board will show AAAA (Correct). If not, it will show FFFF(false)
This program can be easily modified so that MIPS can do any program that is being written on his Instruction Fetch  
The scheme of the MIPS and all the signals between the components is the one attached  
![image](https://user-images.githubusercontent.com/69772634/205272164-27d948b6-6c43-447a-8da6-a0f95e88fc98.png)
