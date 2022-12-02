----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2022 02:46:04 PM
-- Design Name: 
-- Module Name: EX - Behavioral
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

entity EX is
    Port ( RD1 : in STD_LOGIC_VECTOR (15 downto 0);
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           ALUSrc : in STD_LOGIC;
           Ext_Imm : in STD_LOGIC_VECTOR (15 downto 0);
           sa : in STD_LOGIC;
           func : in STD_LOGIC_VECTOR (2 downto 0);
           ALUOp : in STD_LOGIC_VECTOR (1 downto 0);
           PC_inc: in STD_LOGIC_VECTOR (15 downto 0);
           GEZero : out STD_LOGIC;
           Zero : out STD_LOGIC;
           ALURes : out STD_LOGIC_VECTOR (15 downto 0);
           BranchAddr: out STD_LOGIC_VECTOR(15 downto 0)
           );
end EX;

architecture Behavioral of EX is
signal A, B, C: std_logic_vector(15 downto 0);
signal AluCTRL : std_logic_vector(2 downto 0);
signal Hi: std_logic_vector(31 downto 0);
begin

A<=RD1;
Alures<=C;
BranchAddr <= Ext_Imm + Pc_Inc;
MUX: B <= RD2 when AluSrc = '0' else Ext_Imm;

process(ALUOP, func)
begin
case (AluOp) is
    when "00" => 
        case(func) is
        when "000" => ALUCtrl <="000";   -- +
        when "001" => ALUCtrl <="001";   -- -
        when "010" => ALUCtrl <="010";   -- <<
        when "011" => ALUCtrl <="011";   -- >>
        when "100" => ALUCtrl <="100";   -- &
        when "101" => ALUCtrl <="101";   -- |
        when "110" => ALUCtrl <="110";   -- *
        when "111" => ALUCtrl <="111";   -- incarc registrul cu Hi
        end case;
    when "01" => ALUCtrl <= "001";
    when "10" => ALUCtrl <= "000";
    when "11" => ALUCtrl <= "101"; 
end case;
end process;

process (ALUCtrl,A,B,C)
begin
    case(ALUCtrl) is
    when "000" => C <= A + B;
    when "001" => if(func = "001") then C <= A - B; 
                   else C <= B; end if;
                   if (A-B) = x"0000" then zero <='1'; else zero<='0'; end if;
                   if (A-B) >= x"0000" then gezero<='1'; else gezero<='0'; end if;
    when "010" => if(sa='1') then C <= RD1(14 downto 0)&'0'; end if;
    when "011" => if(sa='1') then C <= RD1(15)&RD1(15 downto 1); end if;
    when "100" => C <= A and B;
    when "101" => C <= A or B;
    when "110" => Hi <=  a * b;
                  C<= Hi(15 downto 0);
    when "111" => C <= Hi(15 downto 0);
    end case;
end process;

--process(ALUCTRL)
--begin
--    if(ALUCtrl = "001") then
--        if(C = 0) then
--             zero <= '1';
--        else zero<='0';
--        end if;
--        if(C >=0) then 
--            gezero <='1';
--          else gezero<='0';  
--        end if;
--    end if;
        
--end process;
end Behavioral;
