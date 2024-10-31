-- Where it will read the program binary file
library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
use std.textio.all;

ENTITY RAM_TB IS 
-- empty
END ENTITY;

ARCHITECTURE Behavioral OF RAM_TB IS

SIGNAL DATAIN : STD_LOGIC_VECTOR(31 DOWNTO 0):= x"FFFFFFFF";
SIGNAL ADDRESS : STD_LOGIC_VECTOR(7 DOWNTO 0):= "00000000";
SIGNAL W_R : STD_LOGIC:='0';
SIGNAL DATAOUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL address_counter : integer := 0; -- Initialize the counter

COMPONENT RAM IS
    PORT(DATAIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         ADDRESS : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         W_R : IN STD_LOGIC;
         DATAOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
         );
END COMPONENT;

BEGIN

  -- Connect DUT
  UUT: RAM PORT MAP(DATAIN, ADDRESS, W_R, DATAOUT);
  
  PROCESS
  
  file text_file : text open read_mode is "test.txt";
  variable text_line : line;
  variable ok : boolean;
  variable data : STD_LOGIC_VECTOR(31 DOWNTO 0);
  
  BEGIN

  while not endfile(text_file) loop
  	readline(text_file, text_line);
    hread(text_line, data, ok);
  	DATAIN <= data;
    ADDRESS <= std_logic_vector(to_unsigned(address_counter, ADDRESS'length));
    address_counter <= address_counter + 1;
    WAIT FOR 100 ns;
  end loop;

    -- Read data from RAM
    W_R<='1';
    
    ADDRESS<="00000000";
    wait for 100 ns;
    
    for i in 0 to address_counter loop
    ADDRESS <= std_logic_vector(to_unsigned(i, ADDRESS'length));
    
    ASSERT FALSE REPORT "Test done. Open EPWave to see signals." SEVERITY NOTE;
    WAIT;
  END PROCESS;

END Behavioral;
