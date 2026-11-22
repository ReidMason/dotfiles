{
  pkgs,
  config,
  lib,
  parent-name,
  inputs,
  ...
}:
let
  statuslineScript = pkgs.writeShellScript "claude-code-statusline" ''
    input=$(cat)

    model=$(echo "$input" | ${pkgs.jq}/bin/jq -r '.model.display_name')
    dir=$(echo "$input" | ${pkgs.jq}/bin/jq -r '.workspace.current_dir')
    tokens=$(echo "$input" | ${pkgs.jq}/bin/jq -r '(.context_window.total_input_tokens // 0) + (.context_window.total_output_tokens // 0)')

    if [ "$tokens" -ge 1000 ]; then
      tokens_fmt=$(${pkgs.gawk}/bin/awk -v t="$tokens" 'BEGIN { printf "%.1fk", t/1000 }')
    else
      tokens_fmt="$tokens"
    fi

    printf '\033[2m%s\033[0m in \033[2m%s\033[0m | \033[2m%s tokens\033[0m' \
      "$model" "$(basename "$dir")" "$tokens_fmt"
  '';

  mattpocockSkills = inputs.mattpocock-skills;

  mattpocockBuckets = [
    "engineering"
    "productivity"
  ];

  mattpocockSkillNames = lib.concatMap (
    bucket:
    map (name: "${bucket}/${name}") (
      lib.attrNames (lib.filterAttrs (_: type: type == "directory") (
        builtins.readDir "${mattpocockSkills}/skills/${bucket}"
      ))
    )
  ) mattpocockBuckets;

  module = {
    module-name = "claude-code";
    label = "Claude code";
    config = {
      programs.claude-code = {
        enable = true;
        package = pkgs.claude-code;
        context = ../../../configs/claude/CLAUDE.md;
        skills = {
          frontend-design = ../../../configs/claude/skills/frontend-design;
          unslop = ../../../configs/claude/skills/unslop;
        }
        // lib.listToAttrs (
          map (name: {
            name = builtins.baseNameOf name;
            value = "${mattpocockSkills}/skills/${name}";
          }) mattpocockSkillNames
        );
        settings = {
          model = "sonnet";
          effortLevel = "medium";
          autoMemoryEnabled = false;
          theme = "dark";
          disableWorkflows = true;
          disableRemoteControl = true;
          disableArtifact = true;
          statusLine = {
            type = "command";
            command = "${statuslineScript}";
            padding = 0;
          };
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
