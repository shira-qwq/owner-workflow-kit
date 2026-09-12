# Owner Workflow Kit

两个 Owner Skill，配合 Backlog.md 和 Git，帮助非技术项目负责人明确边界、推进任务、保存证据并让新 Agent 接手。

**先看 [使用指南](guide/Owner使用指南.md)**。下载到本机后可双击 `guide/Owner使用指南.html` 看排版版。

## 直接开始

- [新建项目启动词](prompts/新建项目.md)
- [旧项目接手启动词](prompts/接手旧项目.md)
- [下载、安装与同步](#下载与安装)
- [流程图示例](guide/owner-workflow.html)：下载后本地打开；不是实时项目状态。

## 下载与安装

仓库：<https://github.com/shira-qwq/owner-workflow-kit>（私有，需要对应 GitHub 权限）。

你可以直接对 Agent 说：

> 从 https://github.com/shira-qwq/owner-workflow-kit 安装我的 Owner 工作方式。先检查是否已经下载和安装；已有副本不覆盖未知改动，确认远端正确后只做安全更新。没有副本时下载到独立工具目录，不要放入业务项目。读取 README，安装两个 Skill，保留旧版备份；检查 Backlog 可用。不要升级已有 Superpowers，也不要自动开始业务施工。

Agent 或熟悉命令的用户可执行：

```powershell
git clone https://github.com/shira-qwq/owner-workflow-kit.git
cd owner-workflow-kit
```

Windows 解压 ZIP 或 clone 后，双击 **`install.cmd`**。这会备份并安装两个 Skill 到用户 `.agents/skills`；已有内容一致则不重复安装。已有 Backlog 保留版本，缺失时尝试通过 npm 安装官方 `backlog.md@1.51.0`。没有 Node/npm 时明确提示缺少依赖，不声称一切安装完成。运行只对本次 PowerShell 进程设置执行策略，不修改系统策略。

有自定义技能目录（例如某个 ZCode 配置）时，让 Agent 检查它实际使用的路径，再运行 `scripts/install.ps1 -Destination <真实路径>`。本包默认目标适用于当前 Codex 用户环境，不假定所有 Agent 都读取相同目录。安装后新一轮或新对话确认技能可发现；必要时重启应用。

**两种包的区别：** GitHub 的 Code → Download ZIP 是仓库快照；Releases 里的 `owner-workflow-kit-v1.0.0.zip` 是本次验证过的固定版本。两者都要先解压，不要在压缩软件里直接运行安装。ZIP 不含 Git 历史，不会自行更新；长期维护优先 clone。

## 同步到哪里

- 本仓库只保存通用 Skill、指南、启动词与小型示例。
- 每个业务项目的代码、Backlog 卡片、小证据和项目说明放在**你自己的独立项目仓库**。
- Backlog 程序从 [官方项目](https://github.com/MrLesk/Backlog.md) 的发布渠道安装，不需要 clone 官方源码，不把官方仓库作为你的任务库。
- 使用别人代码时保留来源和许可证；向自己有权使用的仓库同步，原作者仓库只作为上游来源。不要把本工具包 clone 成业务项目的模板代码，不上传生产数据、密钥或机器缓存。

本仓库更新由 Agent 在确认没有未知改动后执行 `git pull --ff-only`，再重新安装；不能直接 pull 覆盖修改过的副本。新电脑先登录有权限的 GitHub，再下载本工具包和所需业务项目。

## 目录与地图

允许安全整理外层目录与散落产物，但先检查依赖、保存旧→新映射并验证入口。已有包内路径、数据位置和构建配置不为了好看乱搬。

默认只需简短入口、必要目录说明。数据复杂或需要理解某个功能时复用已有地图，或按需用 [Archify](https://github.com/tt-a1i/archify) 画局部图；不必每个项目先生成全仓文件地图。本包不捆绑安装 Archify 或 Superpowers。

## 内容和来源

- `owner-plain-language-zh/`：对 Owner 讲清楚事实与状态。
- `owner-project-control/`：批准范围、任务秩序、保存与接手；参考文件按需加载。
- `prompts/`：两个可直接复制的启动词，不自动并入每轮上下文。
- `guide/`：给人的说明与示例，不要求 Agent 开工前全文阅读。
- `scripts/`：Windows 安装和发布包构建。

第三方来源见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。本仓库不授予其他项目的额外权利。目录规范参考 [Cookiecutter Data Science](https://cookiecutter-data-science.drivendata.org/)，只采用原始数据保护、派生产物与源代码分开的原则，不要求其完整目录模板。
