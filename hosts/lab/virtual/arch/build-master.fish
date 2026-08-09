#!/usr/bin/env fish

set SCRIPT_DIR (dirname (status filename))
set PAYLOAD "$SCRIPT_DIR/payload.sh"
set SSH_PORT 2222
set TARGET "arch@127.0.0.1"

if not test -f "$PAYLOAD"
    echo "Error: Payload script not found at $PAYLOAD"
    exit 1
end

echo "Checking SSH connectivity to Arch VM on port $SSH_PORT..."

if not ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=5 -p $SSH_PORT $TARGET "echo connection_ok" 2>/dev/null
    echo "Error: Cannot reach Arch VM on port $SSH_PORT"
    echo "Ensure arch-vm.service is active on lab."
    exit 1
end

echo "Sending payload.sh over SSH to provision Arch VM..."

cat "$PAYLOAD" | ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p $SSH_PORT $TARGET "bash -s"

echo "Guest provisioning complete."
