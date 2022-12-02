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

entity test_env is
Port ( btn : in STD_LOGIC_VECTOR (4 downto 0);
           clk : in STD_LOGIC;
           sw: in STD_LOGIC_VECTOR (15 downto 0);
           cat: out STD_LOGIC_VECTOR (6 downto 0);
           an: out STD_LOGIC_VECTOR(3 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end test_env;
architecture Behavioral of test_env is

component MPG is
Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           enable : out STD_LOGIC         
           );
end component;
component Lucrare_IF is
    Port ( en : in STD_LOGIC;
           BrAddr : in STD_LOGIC_VECTOR(15 downto 0);
           JAddr : in STD_LOGIC_VECTOR(15 downto 0);
           PCSrc : in STD_LOGIC;
           J : in STD_LOGIC;
           clk: in std_logic;
           rst: in std_logic;
           instr : out STD_LOGIC_VECTOR (15 downto 0);
           pc_1 : out STD_LOGIC_VECTOR (15 downto 0));
end component;
component ID is
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
end component;
component UC is
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
end component;
component EX is
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
end component;
component MEM is
    Port ( MemWR : in STD_LOGIC;
           ALURes_in : in STD_LOGIC_VECTOR (15 downto 0);
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           MemData : out STD_LOGIC_VECTOR (15 downto 0);
           ALURes_out : out STD_LOGIC_VECTOR (15 downto 0));
end component;
component Afisor is
               Port ( Digit0 : in STD_LOGIC_VECTOR (3 downto 0);
                      Digit1 : in STD_LOGIC_VECTOR (3 downto 0);
                      Digit2 : in STD_LOGIC_VECTOR (3 downto 0);
                      Digit3 : in STD_LOGIC_VECTOR (3 downto 0);
                      CLK : in STD_LOGIC;
                      cat: out STD_LOGIC_VECTOR(6 downto 0);
                      an: out STD_LOGIC_VECTOR(3 downto 0));
end component;

signal s_en,s_rst,s_PCSRC: std_logic;
signal s_zero,s_gezero, s_GezRes, s_ZeroRes:std_logic;
signal s_BrAddr, s_JAddr, s_Instr, s_PcInc: std_logic_vector(15 downto 0);
signal s_RegDst,s_ExtOp,s_ALUSrc, s_branch,s_gezbranch, s_jump,s_MemWR, s_MemtoReg, s_RegWR: std_logic;
signal AluOp: std_logic_vector(1 downto 0);
signal s_rd1,s_rd2,s_ext_imm,s_ALURes_in, s_ALURes_out,s_MemData: std_logic_vector(15 downto 0);
signal out_mux2, out_mux1: std_logic_vector(15 downto 0);
signal s_func: std_logic_vector(2 downto 0);
signal s_sa: std_logic;
begin

monopulse1: MPG port map (clk,btn(0),s_en);
monopulse2: MPG port map (clk,btn(1),s_rst);
IFF: Lucrare_IF port map (s_en,s_BrAddr,s_JAddr,s_PCSrc,s_jump,clk,s_rst,s_instr,s_pcInc);
IDD: ID port map (s_regWr, s_instr,s_regDST,out_mux2,clk,s_extop,s_en,s_rd1,s_rd2,s_ext_imm,s_func,s_sa);
UCC: UC port map (s_instr, s_regdst, s_regWR, s_extop,s_AluSrc,AluOP,s_branch,s_gezbranch,s_jump,s_memwr,s_memtoreg);
EXX: EX port map (s_RD1,s_RD2,s_alusrc,s_Ext_Imm,s_sa,s_func,aluop,s_PcInc,s_gezero,s_zero,s_ALURes_in,s_BrAddr);
MEMM: MEM port map (s_memWR, s_ALURes_in,s_RD2,clk,s_en,s_MemData,s_ALURes_out);
SSD: Afisor port map (out_mux1(3 downto 0),out_mux1(7 downto 4), out_mux1(11 downto 8), out_mux1(15 downto 12),clk,cat,an);

s_jAddr<= s_pcInc(15 downto 13)&s_instr(12 downto 0);
process(s_MemtoReg,s_Alures_out, s_MemData)
begin
    case(s_MemtoReg) is
    when '0' => out_mux2 <= s_ALURes_out;
    when '1' => out_mux2 <= s_MemData;
    end case;
end process;

process(sw(7 downto 5), s_instr,s_pcinc,s_rd1,s_rd2,out_mux2,s_ext_imm)
begin
case sw(7 downto 5) is
    when "000" => out_mux1<=s_instr;
    when "001" => out_mux1<=s_pcinc;
    when "010" => out_mux1<=s_rd1;
    when "011" => out_mux1<=s_rd2;
    when "100" => out_mux1<=s_ext_imm;
    when "101" => out_mux1<=s_ALURes_in;
    when "110" => out_mux1<=s_MemData;
    when "111" => out_mux1<=out_mux2;
end case;
end process;
led(10 downto 0) <= (s_RegDST&s_RegWR&s_ExTop&s_ALUSrc&ALUOp&s_Branch&s_GEZBranch&s_MemWR&s_MemtoREG&s_Jump);
s_GezRes <= s_gezero and s_gezbranch;
s_ZeroRes <= s_zero and s_branch;
s_PCSrc <= s_gezRes or s_ZeroRes;











end Behavioral;
