-- Where it will perform the CPU process
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE IEEE.NUMERIC_STD.ALL;

-- RAM entitiy - where the instructions will be stored (basic inputs and outputs)
entity RAM is
  port(
    DATAIN: in std_logic_vector(31 downto 0); -- 32 bit input
    ADDRESS: in std_logic_vector(7 downto 0); -- 8 bit address 
    W_R: in std_logic; -- write when 0, read when 1
    DATAOUT: out std_logic_vector(31 downto 0)); -- 32 bit output
end entity;

-- RAM architecture - the inside of the memory (read from memory and write into memory)
architecture behavioral of RAM is 
-- Change the array type to hold 32 bits values

type MEM is array (255 downto 0) of std_logic_vector(31 downto 0);
signal MEMORY : MEM;
signal ADDR : integer range 0 to 255;

begin
  proces(ADDRESS, DATAIN, W_R)
  begin
    ADDR <= conv_integer(ADDRESS); -- Convert std_logic_vector to integer
    if (W_R = '0') then
      MEMORY(ADDR) <= DATAIN; -- Write data into memory
    elsif (W_R = '1') then
      DATAOUT <= MEMORY(ADDR); -- Read data from memory
    else
      DATAOUT <= (others => z'); -- High impedance state
    end if; 
  end process;
end behavioral;

--------------------------------------------------------------
--- Design entity - link between modules and test benth
entity design is
    Port ( CLK : in STD_LOGIC;
           );        
end design;

architecture Behavioral of design is

signal DATAIN_IN, DATAOUT_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);  
signal ADDRESS_IN : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal W_R_IN : STD_LOGIC;

Component RAM IS
  PORT(
       DATAIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
       ADDRESS : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
       W_R : IN STD_LOGIC;
       DATAOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
       );
END Component;
      
Begin

u1: RAM port map(DATAIN => DATAIN_IN, ADDRESS => ADDRESS_IN, W_R => W_R_IN, DATAOUT => DATAOUT_OUT);
end Behavioral;
