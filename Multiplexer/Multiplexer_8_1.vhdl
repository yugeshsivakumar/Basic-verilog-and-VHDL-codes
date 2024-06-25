-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multi is
    Port (
        din : in std_logic_vector(7 downto 0);
        sel : in std_logic_vector(2 downto 0);
        en : in std_logic;
        out : out std_logic
    );
end multi;

architecture Behavioral of multi is
begin
    process (din, sel, en)
    begin
        if en = '0' then
            out <= 'X';  -- Output is undefined when enable is low
        else
            case sel is
                when "000" =>
                    out <= din(0);
                when "001" =>
                    out <= din(1);
                when "010" =>
                    out <= din(2);
                when "011" =>
                    out <= din(3);
                when "100" =>
                    out <= din(4);
                when "101" =>
                    out <= din(5);
                when "110" =>
                    out <= din(6);
                when "111" =>
                    out <= din(7);
                when others =>
                    out <= 'Z';  -- Default output is high-impedance
            end case;
        end if;
    end process;
end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal din : std_logic_vector(7 downto 0);
    signal sel : std_logic_vector(2 downto 0);
    signal en : std_logic;
    signal out : std_logic;
    constant CLK_PERIOD : time := 10 ns;  -- Simulation clock period

begin
    -- Stimulus process
    stim_proc: process
    begin
        en <= '0';
        wait for 5 ns;
        en <= '1';
        
        din <= "10010011";
        wait for CLK_PERIOD * 5;
        
        for i in 0 to 7 loop
            sel <= std_logic_vector(to_unsigned(i, sel'length));
            wait for CLK_PERIOD;
        end loop;
        
        en <= '0';
        wait for CLK_PERIOD * 50;
        report "Simulation finished";
        wait;
    end process;

    -- Instance of multi module
    multi_inst: entity work.multi
        port map (
            din => din,
            sel => sel,
            en => en,
            out => out
        );

    -- Monitor process
    monitor_proc: process (out, en, din, sel)
    begin
        wait for CLK_PERIOD;
        report "Enable = " & std_logic'image(en) &
               " DataIn = " & std_logic_vector'image(din) &
               " sel = " & std_logic_vector'image(sel) &
               " Out = " & std_logic'image(out);
        wait;
    end process;

end Behavioral;

