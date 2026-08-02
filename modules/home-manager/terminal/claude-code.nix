{
  pkgs,
  config,
  lib,
  parent-name,
  ...
}:
let
  module = {
    module-name = "claude-code";
    label = "Claude code";
    config = {
      programs.claude-code = {
        enable = true;
        package = pkgs.claude-code;
        context = ../../../configs/claude/CLAUDE.md;
        skills = ../../../configs/claude/skills;
        settings = {
          model = "sonnet";
          effortLevel = "medium";
          autoMemoryEnabled = false;
          theme = "dark";
          disableWorkflows = true;
          disableRemoteControl = true;
          disableArtifact = true;
          permissions = {
            deny = [
              "mcp__claude_ai_Google_Drive__*"
              "EnterPlanMode"
              "DesignSync"
              "NotebookEdit"
              "CronCreate"
              "CronList"
              "CronDelete"
              "EnterWorktree"
              "ExitWorktree"
              "PushNotification"
            ];
          };
        };
      };
    };
  };
in
{
  imports = [
    (import ../module-setup.nix {
      inherit
        config
        lib
        parent-name
        module
        ;
    })
  ];
}
