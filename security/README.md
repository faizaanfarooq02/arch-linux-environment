SECURITY HARDENING:

Hardening Tweak 1(Network Exposure):

[QUICK OVERVIEW / REASONING]
- I scanned TCP/UDP ports to see what services could be listening on those ports, decided on whether those services were necessary for this machine, disabled/kept on to reduce the attack surface without diminishing usability of the environment. I did not require the printing service/CUPS so decided to disable the service immediately and prevent it from re-enabling unless I consciously require it in the future and turn it on for a moment, this is to reduce the potential attach surface and is my first step towards continual security hardening on this environment.

[sudo ss -tulpn]
- This is used to audit listening on TCP/UDP sockets.
- Listening service = application waiting for incoming connections.

[Findings]
- CUPS service was listening on port 631 which was bound to 127.0.0.1 which is a loopback IP (Not externally exposed)

[systemctl status cups]
- Checks the service status for CUPS.
- Showed that CUPS was enabled and running.
- cups.socket/path could reactivate it.

[Mitigation]
- I do not require printing on this machine and environment therefore unecessary services > unecessary attack surface.
- Ran [systemctl disable --now cups.service cups.socket cups.path] > Immediately disabled the service and prevents automatic activation.

[Test/ sudo ss -tulpn]
- No listening on TCP/UDP sockets // verified remediation
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Hardening Tweak 2 (Baseline Host Firewall Configuration):

[QUICK OVERVIEW / REASONING]
- I installed UFW to configure a basic host firewall on this machine. I set the default incoming policy to deny whilst keeping outgoing traffic allowed, this means new inbound connections are blocked unless I (system administrator) explicitly allow the connection.

[sudo pacman -S ufw]

- Installed UFW.
- UFW is a frontend used to simplify management of the Linux host firewall.
- Linux provides the underlying packet-filtering capabilities; UFW provides a simpler way to configure the firewall policy.

[sudo ufw status]

- Checked whether UFW was currently active, in which UFW was turned off.

[Configuration]

[sudo ufw default deny incoming]

- Configured and set the default policy to deny unsolicited incoming connections, follows the "default-deny" security principle.
- Connections initiated by this machine can still receive legitimate return traffic because the firewall is stateful.

[sudo ufw enable]

- Enabled the configured firewall policy.

[sudo systemctl enable ufw]

- Enabled the UFW systemd service so the firewall configuration is applied after reboot.

[Test / sudo ufw status verbose]

- Status: active.
- Incoming: deny.
- Outgoing: allow.
- Routed: disabled.
- Logging: low.


