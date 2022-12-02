----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2022 09:04:20 PM
-- Design Name: 
-- Module Name: MPG - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--rol1: elimina zgomotul
--rol2: oricat apas butonul, el tot un singur puls o sa-mi genereze (o apasare singulara de buton)

entity MPG is
Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           enable : out STD_LOGIC        
           );
end MPG;
architecture Behavioral of MPG is

signal out_count : std_logic_vector(15 downto 0) := (others => '0');
signal q : std_logic_vector(2 downto 0) := (others => '0');
signal en : std_logic := '0';

begin
process(clk)
begin
    if rising_edge(clk) then
            out_count <= out_count+1;
    end if;
end process;

process(out_count)
begin
    case out_count is
    when "1111111111111111" => en <= '1';
    when others => en <= '0';
    end case;
end process;

process(clk)
begin
if rising_edge(clk) then
    if en = '1' then
        q(2) <= btn;
    end if;
    q(1) <= q(2);
    q(0) <= q(1);
end if;
end process;

process(q)
begin
    enable <= q(1) and not q(0);
end process;

end Behavioral;
