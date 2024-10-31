-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity melay is
    Port (
        Data_in  : in  STD_LOGIC;
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        Data_out : out STD_LOGIC
    );
end melay;

architecture Behavioral of melay is
    type state_type is (s0, s1, s11, s110, s10, s101);
    signal current_state, next_state : state_type;
begin

    -- State transition on clock edge or reset
    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= s0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Next state logic
    process(Data_in, current_state)
    begin
        case current_state is
            when s0 =>
                if Data_in = '0' then
                    next_state <= s0;
                else
                    next_state <= s1;
                end if;
            when s1 =>
                if Data_in = '0' then
                    next_state <= s10;
                else
                    next_state <= s11;
                end if;
            when s11 =>
                if Data_in = '0' then
                    next_state <= s110;
                else
                    next_state <= s11;
                end if;
            when s110 =>
                if Data_in = '1' then
                    next_state <= s101;
                else
                    next_state <= s0;
                end if;
            when s10 =>
                if Data_in = '1' then
                    next_state <= s101;
                else
                    next_state <= s0;
                end if;
            when s101 =>
                if Data_in = '1' then
                    next_state <= s11;
                else
                    next_state <= s10;
                end if;
            when others =>
                next_state <= s0;
        end case;
    end process;

    -- Output logic
    process(current_state, Data_in)
    begin
        case current_state is
            when s0 =>
                Data_out <= '0';
            when s1 =>
                Data_out <= '0';
            when s11 =>
                if Data_in = '1' then
                    Data_out <= '0';
                else
                    Data_out <= '1';
                end if;
            when s110 =>
                Data_out <= '0';
            when s101 =>
                Data_out <= '0';
            when s10 =>
                if Data_in = '1' then
                    Data_out <= '1';
                else
                    Data_out <= '0';
                end if;
            when others =>
                Data_out <= '0';
        end case;
    end process;

end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity melay_tb is
end melay_tb;

architecture Behavioral of melay_tb is
    signal Data_in_tb : STD_LOGIC;
    signal clk_tb     : STD_LOGIC := '0';
    signal rst_tb     : STD_LOGIC;
    signal Data_out_tb : STD_LOGIC;

    -- Component Declaration for the Unit Under Test (UUT)
    component melay
        Port (
            Data_in  : in  STD_LOGIC;
            clk      : in  STD_LOGIC;
            rst      : in  STD_LOGIC;
            Data_out : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the UUT
    DUT: melay port map(Data_in => Data_in_tb, clk => clk_tb, rst => rst_tb, Data_out => Data_out_tb);

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk_tb <= '1';
            wait for 10 ns;
            clk_tb <= '0';
            wait for 10 ns;
        end loop;
    end process;

    -- Reset and input generation
    process
    begin
        -- Initialize signals
        Data_in_tb <= '0';
        rst_tb <= '0';
        
        -- Reset the design
        rst_tb <= '1';
        wait for 20 ns; -- Wait for two clock cycles
        rst_tb <= '0';

        -- Apply test inputs
        wait for 20 ns; -- Wait before the first input
        Data_in_tb <= '1';
        wait for 20 ns;
        Data_in_tb <= '0';
        wait for 20 ns;
        Data_in_tb <= '1';
        wait for 20 ns;
        Data_in_tb <= '1';
        wait for 20 ns;
        Data_in_tb <= '0';

        wait; -- Wait indefinitely
    end process;

end Behavioral;