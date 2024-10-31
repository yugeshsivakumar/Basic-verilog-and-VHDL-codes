-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_81 is
    Port (
        i : in  STD_LOGIC_VECTOR(7 downto 0);
        s : in  STD_LOGIC_VECTOR(2 downto 0);
        y : out STD_LOGIC
    );
end mux_81;

architecture Behavioral of mux_81 is
begin

    process(i, s)
    begin
        case s is
            when "000" =>
                y <= i(0);
            when "001" =>
                y <= i(1);
            when "010" =>
                y <= i(2);
            when "011" =>
                y <= i(3);
            when "100" =>
                y <= i(4);
            when "101" =>
                y <= i(5);
            when "110" =>
                y <= i(6);
            when "111" =>
                y <= i(7);
            when others =>
                y <= 'Z'; -- High impedance state
        end case;
    end process;

end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_81_tb is
end mux_81_tb;

architecture Behavioral of mux_81_tb is
    signal i : STD_LOGIC_VECTOR(7 downto 0);
    signal s : STD_LOGIC_VECTOR(2 downto 0);
    signal y : STD_LOGIC;

    -- Component Declaration for the Unit Under Test (UUT)
    component mux_81
        Port (
            i : in  STD_LOGIC_VECTOR(7 downto 0);
            s : in  STD_LOGIC_VECTOR(2 downto 0);
            y : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the UUT
    uut: mux_81 port map(i => i, s => s, y => y);

    -- Stimulus process
    process
    begin
        for j in 0 to 255 loop
            {i, s} <= std_logic_vector(to_unsigned(j, 11)); -- Concatenate and convert to std_logic_vector
            wait for 10 ns;
        end loop;
        wait;  -- Wait indefinitely
    end process;

    -- Monitor process
    process
    begin
        wait for 10 ns; -- Wait for the first change
        while true loop
            report "S=" & std_logic_vector(s) & " i=" & std_logic_vector(i) & " y=" & std_logic'image(y);
            wait for 10 ns;
        end loop;
    end process;

end Behavioral;