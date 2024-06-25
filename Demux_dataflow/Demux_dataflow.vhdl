-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux is
    Port ( in  : in  STD_LOGIC;                -- Input signal
           s1  : in  STD_LOGIC := '0';         -- Select signal 1
           s2  : in  STD_LOGIC := '0';         -- Select signal 2
           out : out STD_LOGIC_VECTOR (3 downto 0) -- 4-bit output
         );
end demux;

architecture Behavioral of demux is
begin

    process(in, s1, s2)
    begin
        out <= (others => '0');  -- Default output to 0
        if s1 = '1' then
            if s2 = '1' then
                out(3) <= in;
            else
                out(2) <= in;
            end if;
        else
            if s2 = '1' then
                out(1) <= in;
            else
                out(0) <= in;
            end if;
        end if;
    end process;

end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal in  : STD_LOGIC := '0';                   -- Input signal
    signal s1  : STD_LOGIC := '0';                   -- Select signal 1
    signal s2  : STD_LOGIC := '0';                   -- Select signal 2
    signal out : STD_LOGIC_VECTOR (3 downto 0);      -- 4-bit output signal

    -- Component declaration for the demux module
    component demux
        Port ( in  : in  STD_LOGIC;
               s1  : in  STD_LOGIC;
               s2  : in  STD_LOGIC;
               out : out STD_LOGIC_VECTOR (3 downto 0)
             );
    end component;

begin

    -- Instantiate the demux module
    uut: demux port map (in => in, s1 => s1, s2 => s2, out => out);

    -- Stimulus process to generate test patterns
    stim_proc: process
    begin
        report "Time = " & integer'image(now) & "  in = " & std_logic'image(in) & "  sel = " & std_logic'image(s1) & std_logic'image(s2) & "  out = " & std_logic_vector'image(out);

        -- Test pattern
        in <= '0'; s1 <= '0'; s2 <= '0';
        wait for 2 ns;
        in <= '1'; s1 <= '0'; s2 <= '0';
        wait for 2 ns;
        s1 <= '0'; s2 <= '1';
        wait for 2 ns;
        s1 <= '1'; s2 <= '0';
        wait for 2 ns;
        s1 <= '1'; s2 <= '1';
        wait for 2 ns;

        report "Simulation finished.";
        wait;
    end process;

end Behavioral;