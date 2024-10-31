-- Where it will perform the CPU process
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

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
-- InstructionDecoder Entity - where it will fetch and decode 
