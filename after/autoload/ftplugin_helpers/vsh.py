import vim

def vsh_outputlen(buf, curline):
    # If on last line, loop below will not assign count to anything, we need
    # count.
    count = 0

    prompt = buf.vars['prompt']
    # curline represents the first line of output.
    for (count, line) in enumerate(buf[curline:]):
        # Want to use vim match() so that if we decide to allow regexp prompts
        # in the future the match will behave like vim.
        # Reading the help pages, I would use the vim.Funcref() constructor and
        # work with the vim function inside python, but this object isn't
        # foundu in the neovim client.
        if line.startswith(prompt):
            break

    return count


def vsh_insert_text(data, insert_buf):
    '''
    Insert text into a vsh buffer in the correct place.
    Don't modify the user state and don't interrupt their workflow.

    '''
    try:
        vsh_buf = vim.buffers[int(insert_buf)]
    except KeyError:
        vim.command('echoerr "Vsh text recieved for invalid buffer"')
        return

    # Don't print out the starting prompt of the shell.
    if 'initialised' not in vsh_buf.vars:
        vsh_buf.vars['initialised'] = 1
        # TODO Find a better way to check this is just the starting prompt of
        # the shell. This seems brittle.
        if len(data) == 1:
            return

    # Default to inserting text at end of file if input mark doesn't exist.
    active_prompt, _ = vsh_buf.mark('d')
    if active_prompt == 0:
        # Use the total length of the buffer because active_prompt is a Vim
        # line number not a python buffer index.
        active_prompt = len(vsh_buf.buffer)

    # This function is called on each flush of output.
    # We are reading from a pty, which may flush in the middle of a command.
    # Quite often the last entry in this list is empty, representing the
    # newline the pty emitted to help get ready for the next line of output.
    # When this next output is given to us, we append it linewise, which gives
    # us an extra empty line.
    # This is a brittle hack to stop that.
    # TODO search for faults in this hack and fix if found.
    if data[-1] == '':
        data = data[:-1]

    vsh_buf.append(data, active_prompt + vsh_outputlen(vsh_buf, active_prompt))


def vsh_clear_output(curline):
    outputlen = vsh_outputlen(vim.current.buffer, curline)
    vim.current.buffer[curline:curline + outputlen] = []
