{
  pkgs,
  config,
  lib,
  parent-name,
  inputs,
  ...
}:
let
  mattpocockSkills = inputs.mattpocock-skills;

  # Skills vendored from github:mattpocock/skills, named `category/skill-name`.
  mattpocockSkillNames = [
    "productivity/grill-me"
    "productivity/handoff"
    "productivity/teach"
    "engineering/ask-matt"
    "engineering/grill-with-docs"
    "engineering/to-spec"
    "engineering/to-tickets"
    "engineering/implement"
    "engineering/code-review"

    # "productivity/grilling"
    # "productivity/to-questionnaire"
    # "productivity/wait-what"
    # "productivity/writing-for-agents"
    # "engineering/codebase-design"
    # "engineering/diagnosing-bugs"
    # "engineering/domain-modeling"
    # "engineering/improve-codebase-architecture"
    # "engineering/prototype"
    # "engineering/research"
    # "engineering/resolving-merge-conflicts"
    # "engineering/setup-matt-pocock-skills"
    # "engineering/tdd"
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
