----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/30/2022 12:28:36 AM
-- Design Name: 
-- Module Name: ID - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ID is
    Port ( RegWrite : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (15 downto 0);
           RegDst : in STD_LOGIC;
           WriteData : in STD_LOGIC_VECTOR (15 downto 0);
           CLK : in STD_LOGIC;
           ExtOP : in STD_LOGIC;
           EN: in std_logic;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           EXT_Imm : out STD_LOGIC_VECTOR (15 downto 0);
           func : out STD_LOGIC_VECTOR (2 downto 0);
           sa : out STD_LOGIC);
end ID;

architecture Behavioral of ID is
type reg_array is array (0 to 15) of std_logic_vector(15 downto 0);
signal reg_file : reg_array := (
others=>x"0000");
signal out_mux: std_logic_vector(2 downto 0);

begin

process(RegDst, Instr(9 downto 7), Instr(6 downto 4))
begin
case(RegDst) is
    when '0' => out_mux <= Instr(9 downto 7);
    when '1' => out_mux <= Instr(6 downto 4);
end case;
end process;

process(ExtOp, Instr(6 downto 0))
begin
case(ExtOp) is
    when '0' => ext_imm <= "000000000"&Instr(6 downto 0);
    when '1' => ext_imm <= Instr(6)&Instr(6)&Instr(6)&Instr(6)&Instr(6)&Instr(6)&Instr(6)&Instr(6)&Instr(6)&Instr(6 downto 0);
end case;
end process;


process(clk)
begin
    if rising_edge(clk) then
       if en = '1' and RegWrite<='1' then
            reg_file(conv_integer(out_mux)) <= WriteData;
        end if;
    end if;
end process;

RD1 <= reg_file(conv_integer(Instr(12 downto 10)));
RD2 <= reg_file(conv_integer(Instr(9 downto 7)));

func <= instr(2 downto 0);
sa <= instr(3);
end Behavioral;
