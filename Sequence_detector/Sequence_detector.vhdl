-- design 


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seq is
  Port (
    clk : in std_logic;
    in : in std_logic_vector(15 downto 0);
    out : out std_logic;
    count : out std_logic_vector(2 downto 0)
  );
end seq;

architecture Behavioral of seq is

  signal state : std_logic_vector(2 downto 0) := "001";
  
  signal b1 : std_logic_vector(3 downto 0) := "1111";
  signal b2 : std_logic_vector(3 downto 0) := "1110";
  signal b3 : std_logic_vector(3 downto 0) := "1101";
  signal b4 : std_logic_vector(3 downto 0) := "1100";

begin

  process(clk)
  begin
    if rising_edge(clk) then
      case state is
        when "000" =>
          b1 <= b1 - "0001";
          b2 <= b2 - "0001";
          b3 <= b3 - "0001";
          b4 <= b4 - "0001";
          state <= "001";
        
        when "001" =>
          if (in(to_integer(unsigned(b1))) = '1') then
            state <= "010";
          else
            state <= "110";
            out <= '0';
          end if;
        
        when "010" =>
          if (in(to_integer(unsigned(b2))) = '0') then
            state <= "011";
          else
            state <= "110";
            out <= '0';
          end if;
        
        when "011" =>
          if (in(to_integer(unsigned(b3))) = '1') then
            state <= "100";
          else
            state <= "110";
            out <= '0';
          end if;
        
        when "100" =>
          if (in(to_integer(unsigned(b4))) = '1') then
            state <= "101";
          else
            state <= "110";
            out <= '0';
          end if;
        
        when "101" =>
          out <= '1';
          state <= "110";
          count <= std_logic_vector(unsigned(count) + 1);
        
        when "110" =>
          if (b4 = "0000") then
            state <= "000";
          else
            state <= "000";
          end if;
        
        when others =>
          null; -- Not used in this case
      end case;
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
  signal clk : std_logic := '0';
  signal in_signal : std_logic_vector(15 downto 0) := (others => '0');
  signal out_signal : std_logic;
  signal count_signal : std_logic_vector(2 downto 0) := (others => '0');
  
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
    in_signal <= "1011101111001011";
    wait for 100 ns;
    report "Simulation finished";
    wait;
  end process;

  -- Instance of seq module
  seq_inst: entity work.seq
    port map (
      clk => clk,
      in => in_signal,
      out => out_signal,
      count => count_signal
    );

  -- Monitor process
  monitor_proc: process (clk, out_signal, count_signal)
  begin
    wait until rising_edge(clk);
    report "Time=" & integer'image(time) &
           " out=" & std_logic'image(out_signal) &
           " count=" & std_logic_vector'image(count_signal);
    wait;
  end process;

end Behavioral;
