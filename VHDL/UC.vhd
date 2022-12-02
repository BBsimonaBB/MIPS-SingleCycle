----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/30/2022 01:32:03 AM
-- Design Name: 
-- Module Name: UC - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC is
    Port ( Instr : in STD_LOGIC_VECTOR (15 downto 0);
           RegDst : out STD_LOGIC;
           RegWR : out STD_LOGIC;
           ExtOp : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           ALUOp : out STD_LOGIC_VECTOR (1 downto 0);
           Branch : out STD_LOGIC;
           GEZ_Branch: out STD_LOGIC;
           Jump : out STD_LOGIC;
           MemWR : out STD_LOGIC;
           MemtoReg : out STD_LOGIC);
end UC;

architecture Behavioral of UC is

begin
process(Instr)
begin
RegDst<='0'; ExtOp <='0';
ALUSrc<='0'; AluOp<="00";
Branch<='0'; Jump<='0';
GEZ_Branch <='0';
MemWR<='0'; MemtoReg<='0';
RegWR<='0'; 

case(Instr(15 downto 13)) is
when "000" => RegDST<='1'; REGwr <= '1'; AluSRC<='0'; ALUOp<="00"; Branch <='0'; GEZ_Branch <='0'; Jump<='0'; MemWR<='0'; MemtoReg<='0';
when "001" => RegDST<='0'; REGwr <= '1'; ExTop<='1'; AluSRC<='1'; ALUOp <="10"; Branch <='0'; GEZ_Branch <='0'; Jump<='0'; MemWR<='0'; MemtoReg<='0';
when "010" => RegDST<='0'; REGwr <= '1'; ExTop<='1'; AluSRC<='1'; ALUOp <="10"; Branch <='0'; GEZ_Branch <='0'; Jump<='0'; MemWR<='0'; MemtoReg<='1';
when "011" => REGwr <= '0'; ExTop<='1'; AluSRC<='1'; ALUOp <="10"; Branch <='0'; GEZ_Branch <='0'; Jump<='0'; MemWR<='1';
when "100" => REGwr <= '0'; ExTop<='1'; AluSRC<='0'; ALUOp <="01"; Branch <='1'; GEZ_Branch <='0'; Jump<='0'; MemWR<='0';
when "101" => RegDST<='0'; REGwr <= '1'; ExTop<='1'; AluSRC<='1'; ALUOp <="11"; Branch <='0'; GEZ_Branch <='0'; Jump<='0'; MemWR<='0'; MemtoReg<='0';
when "110" => REGwr <= '0'; ExTop<='1'; AluSRC<='1'; ALUOp <="01"; Branch <='0'; GEZ_Branch <='1'; Jump<='0'; MemWR<='0';
when "111" => REGwr <= '0'; Branch <='0'; GEZ_Branch <='0'; Jump<='1'; MemWR<='0';
end case;
end process;

end Behavioral;
