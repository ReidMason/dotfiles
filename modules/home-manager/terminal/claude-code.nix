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

  # Skills vendored from github:mattpocock/skills, named `category/skill-name`.
  mattpocockSkillNames = [
    "productivity/grill-me"
    "productivity/handoff"
    "productivity/teach"
    "productivity/grilling"
    "engineering/ask-matt"
    "engineering/grill-with-docs"
    "engineering/to-spec"
    "engineering/to-tickets"
    "engineering/implement"
    "engineering/code-review"
    "engineering/domain-modeling"

    # "productivity/to-questionnaire"
    # "productivity/wait-what"
    # "productivity/writing-for-agents"
    # "engineering/codebase-design"
    # "engineering/diagnosing-bugs"
    # "engineering/improve-codebase-architecture"
    # "engineering/prototype"
    # "engineering/research"
    # "engineering/resolving-merge-conflicts"
    "engineering/setup-matt-pocock-skills"
    "engineering/tdd"
    # "engineering/triage"
    # "engineering/wayfinder"
    # "engineering/wizard"
  ];

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
