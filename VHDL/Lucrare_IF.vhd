----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2022 10:39:14 AM
-- Design Name: 
-- Module Name: Lucrare_IF - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Lucrare_IF is
    Port ( en : in STD_LOGIC;
           BrAddr : in STD_LOGIC_VECTOR(15 downto 0);
           JAddr : in STD_LOGIC_VECTOR(15 downto 0);
           PCSrc : in STD_LOGIC;
           J : in STD_LOGIC;
           clk: in std_logic;
           rst: in std_logic;
           instr : out STD_LOGIC_VECTOR (15 downto 0);
           pc_1 : out STD_LOGIC_VECTOR (15 downto 0));
end Lucrare_IF;

architecture Behavioral of Lucrare_IF is
type t_mem is array (0 to 255) of std_logic_vector(15 downto 0);
--0 to 2^16-1 ?
signal mem : t_mem:=(
b"000_000_000_110_0_000",
b"000_000_000_111_0_000",
b"000_000_000_001_0_000",
b"001_000_010_0000011",
b"100_001_010_0000011",
b"001_001_001_0000001",
b"000_010_110_110_0_000",
b"111_0000000000100",
b"011_111_110_0000000",
b"000_010_010_010_0_110",
b"010_111_001_0000000",
b"000_001_010_011_0_100",
b"100_001_011_0000001", --aici
b"111_1111111111111",
 b"101_010_101_0101010",
others=>x"0000");
signal out_pc: std_logic_vector(15 downto 0);
signal out_pc_1: std_logic_vector(15 downto 0);
signal out_mux_1: std_logic_vector(15 downto 0);
signal out_mux_2: std_logic_vector(15 downto 0);
begin

process(clk)
begin
    if rising_edge(clk) then
        if(rst='1') then
            out_pc<=x"0000";
        elsif(en = '1') then
        out_pc<=out_mux_2;
        end if;
    end if;
end process;

out_pc_1<=out_pc+1;

process(out_pc_1,BrAddr,PcSRC)
begin
case PcSrc is
    when '0' => out_mux_1 <= out_pc_1;
    when '1' => out_mux_1 <= BrAddr; 
end case;
end process;

process(out_mux_1,JAddr,J)
begin
case J is
    when '0' => out_mux_2 <= out_mux_1;
    when '1' => out_mux_2 <= JAddr;
end case;
end process;
pc_1 <= out_pc_1;

instr <= mem(conv_integer(out_pc(7 downto 0)));
end Behavioral;
