----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2022 07:40:14 PM
-- Design Name: 
-- Module Name: Afisor - Behavioral
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

entity Afisor is
    Port ( Digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           CLK : in STD_LOGIC;
           cat: out STD_LOGIC_VECTOR(6 downto 0);
           an: out STD_LOGIC_VECTOR(3 downto 0));
end Afisor;

architecture Behavioral of Afisor is
signal out_counter: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal out_mux1: STD_LOGIC_VECTOR (3 downto 0):= (others => '0');
signal out_mux2: STD_LOGIC_VECTOR (3 downto 0):= (others => '0');
signal out_hexto7: STD_LOGIC_VECTOR (6 downto 0):= (others => '0');
begin
process(clk)
begin
if rising_edge(CLK) then
    out_counter <= out_counter + 1;   
end if;
end process;

process(out_counter(15 downto 14),Digit0,Digit1,Digit2,Digit3)
begin
case out_counter(15 downto 14) is
    when "00" => out_mux1 <= Digit0;
    when "01" => out_mux1 <= Digit1;
    when "10" => out_mux1 <= Digit2;
    when others => out_mux1 <= Digit3;
end case;

case out_counter(15 downto 14) is
    when "00" => out_mux2 <= "1110";
    when "01" => out_mux2 <= "1101";
    when "10" => out_mux2 <= "1011";
    when others => out_mux2<= "0111";
end case;
an <= out_mux2; --mai e nev de asta sau pot pune asta direct in proces?
end process;

process(out_mux1)
begin
    case out_mux1 is
    when "0000" => out_hexto7 <= "1000000"; -- "0"     
    when "0001" => out_hexto7 <= "1111001"; -- "1" 
    when "0010" => out_hexto7 <= "0100100"; -- "2" 
    when "0011" => out_hexto7 <= "0110000"; -- "3" 
    when "0100" => out_hexto7 <= "0011001"; -- "4" 
    when "0101" => out_hexto7 <= "0010010"; -- "5" 
    when "0110" => out_hexto7 <= "0000010"; -- "6" 
    when "0111" => out_hexto7 <= "1111000"; -- "7" 
    when "1000" => out_hexto7 <= "0000000"; -- "8"     
    when "1001" => out_hexto7 <= "0010000"; -- "9" 
    when "1010" => out_hexto7 <= "0001000"; -- a
    when "1011" => out_hexto7 <= "0000011"; -- b
    when "1100" => out_hexto7 <= "1000110"; -- C
    when "1101" => out_hexto7 <= "0100001"; -- d
    when "1110" => out_hexto7 <= "0000110"; -- E
    when others => out_hexto7 <= "0001110"; -- F
    end case;
cat <= out_hexto7;
end process;
end Behavioral;
