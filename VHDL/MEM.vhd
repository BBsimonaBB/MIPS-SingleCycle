----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2022 04:44:24 PM
-- Design Name: 
-- Module Name: MEM - Behavioral
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

entity MEM is
    Port ( MemWR : in STD_LOGIC;
           ALURes_in : in STD_LOGIC_VECTOR (15 downto 0);
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           MemData : out STD_LOGIC_VECTOR (15 downto 0);
           ALURes_out : out STD_LOGIC_VECTOR (15 downto 0));
end MEM;

architecture Behavioral of MEM is
type t_mem is array (0 to 31) of std_logic_vector(15 downto 0);
--0 to 2^16-1 ?
signal mem : t_mem:=(others=>x"0000");
signal s_address:std_logic_vector(4 downto 0);
signal WD,ReadData : std_logic_vector(15 downto 0);
begin
WD<= RD2;
ALURES_out<=AlURes_in;
s_address <=ALURes_in(4 downto 0);
process(clk)
begin
    if(rising_edge(clk)) then
        if(en = '1' and MemWR ='1') then
            mem(conv_integer(s_address))<=WD;
        end if;
    end if;
end process;
ReadData<=mem(conv_integer(s_address));
MemData<=ReadData;
end Behavioral;
