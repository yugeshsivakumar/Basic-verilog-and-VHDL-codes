-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity enc is
  Port (
    din : in std_logic_vector(7 downto 0);
    en : in std_logic;
    clk : in std_logic;
    dout : out std_logic_vector(2 downto 0)
  );
end enc;

architecture Behavioral of enc is
begin
  process (clk)
  begin
    if rising_edge(clk) then
      if en = '1' then
        case din is
          when "00000001" => dout <= "000";
          when "0000001" & "0" => dout <= "001";
          when "000001" & "00" => dout <= "010";
          when "00001" & "000" => dout <= "011";
          when "0001" & "0000" => dout <= "100";
          when "001" & "00000" => dout <= "101";
          when "01" & "000000" => dout <= "110";
          when "1" & "0000000" => dout <= "111";
          when others => dout <= "zzz";
        end case;
      else
        dout <= "xxx";
      end if;
    end if;
  end process;
end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
  signal din : std_logic_vector(7 downto 0);
  signal en, clk : std_logic;
  signal dout : std_logic_vector(2 downto 0);

  constant CLK_PERIOD : time := 10 ns;  -- Simulation clock period

begin

  -- Clock generation process
  clk_gen_proc: process
  begin
    while true loop
      clk <= '0';
      wait for CLK_PERIOD / 2;
      clk <= '1';
      wait for CLK_PERIOD / 2;
    end loop;
  end process;

  -- Stimulus process
  stim_proc: process
  begin
    wait for 5 ns;
    en <= '0';
    wait for 5 ns;
    en <= '1';
    
    for i in 0 to 7 loop
      din <= std_logic_vector(to_unsigned(i, 8));
      wait for CLK_PERIOD;
    end loop;

    en <= '0';
    wait for 50 ns;
    report "Simulation finished";
    wait;
  end process;

  -- Instance of enc module
  enc_inst: entity work.enc
    port map (
      din => din,
      en => en,
      clk => clk,
      dout => dout
    );

  -- Monitor process
  monitor_proc: process (clk, en, din, dout)
  begin
    wait until rising_edge(clk);
    report "Time=" & integer'image(time) &
           " En=" & std_logic'image(en) &
           " IN=" & std_logic_vector'image(din) &
           " Out=" & std_logic_vector'image(dout);
    wait;
  end process;

end Behavioral;

