# Claude + Roblox Studio + Blender

Script pour Windows qui installe Claude Code et branche Claude à Roblox Studio et Blender.

1. Téléchargez `install.ps1` sur votre ordinateur.
2. Ouvrez PowerShell dans le dossier, puis : `powershell -ExecutionPolicy Bypass -File .\install.ps1`
3. Suivez les 4 étapes manuelles affichées à la fin (activer le MCP dans Studio, installer l'addon dans Blender).
4. Lancez `claude` dans un terminal, avec Studio et Blender ouverts.

Le script n'a pas été testé sur un vrai Windows. Les commandes viennent de la documentation de Claude Code et des dépôts
[ahujasid/blender-mcp](https://github.com/ahujasid/blender-mcp) et d'articles sur le serveur MCP intégré à Roblox Studio.
Si une étape échoue, copiez le message d'erreur et envoyez-le à Claude.
