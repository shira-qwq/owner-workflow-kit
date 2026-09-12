---
name: owner-project-control
description: >-
  接入、恢复或继续 Owner 项目的 Git + Backlog 工作方式；执行 Backlog Task、捕获项目想法、调整需求范围、开展项目研究或批量数据任务、汇报状态或交接时使用。维护批准意图、任务授权、可回滚保存与轻量接手，不重复 Superpowers 的规划、调试、测试和代码审查；不用于无项目关联的普通问答。
metadata:
  when_to_use: >-
    用户把目录或项目交给你开始、继续或整理工作，要求完成任务、先记想法、调整目标、研究或批量处理数据时适用。新 Agent 恢复上下文或询问项目状态与下一步时同样适用。
---

# Owner Project Control

## Purpose

用于接管、新建、恢复或整理一个本地软件 / 研究 / Skill 项目，让项目进入统一、可恢复、对 Owner 可视的工作状态：

- Backlog.md 管任务和进度。
- 项目文件管项目当前事实。
- Git 管版本历史和可回滚状态。
- Backlog.md Web UI 是 Owner 的主要任务可视化界面。

面向非技术 Owner：Owner 不需要自己判断什么时候 git commit、什么时候 push、什么时候建立任务卡。

边界：不重复实现 Superpowers 已有的 brainstorming、planning、debugging、TDD、verification、code review 等能力。本 Skill 负责项目工作秩序：批准意图、任务授权、保存与恢复。具体施工仍交给已有工具。

## 按需读取

- 新项目明确目标、开始任务、收到新想法或需求变化时，读取 [批准意图与范围变更](references/intent-and-scope.md)。同一上下文已读且未变化时不重复加载。普通施工只核对当前任务引用的批准条款。
- 研究、模型 / Prompt 试验、批量处理、预计耗时较长或需要恢复的任务，读取 [研究与数据工作规则](references/research-and-data.md)。普通代码任务不加载它。
- 这里只维护通用规则。项目的数据位置、输入约束、运行命令和质量标准留在该项目已有文档、脚本与任务中。
- 初始化项目时按 [项目入口片段](assets/project-entry.md) 的含义补进已有项目规则并填写真实位置；它用于跨会话提醒，不要求 Owner 每轮手动提 Skill。确认宿主实际读取入口；不能声称 Skill 会后台运行或保证永不漏用。

## 先判断现状，再动手

首先判断当前目录是否已经是一个项目。

- 不得因为本 Skill 存在而擅自重构已有目录。
- 已有的 Git repository、Backlog、任务系统、文档系统、AGENTS.md 规则优先保留并接入，不创建与之重复的系统。
- 持续项目在已有项目规则中留下短入口：本 Skill、当前批准意图文件、handoff 和 Backlog 的位置；不复制整份 Skill，不修改全局 AGENTS.md。已有等价入口直接复用。
- 空白项目先形成足够启动的最小目标；接手他人项目先读现有入口、运行说明和当前相关部分，区分“原项目已有能力”和“Owner 本次要改什么”。不默认完整继承其产品目标，不因初始化而全仓审计。
- 首次接入完成要实际确认 Backlog UI 可达、项目名称正确，给 Owner 可点击地址和一句重新打开方式。启动失败自行排查；不能只写一条命令就宣称界面已可用。不默认设置开机服务或自动执行队列。
- 文件布局优先沿用项目约定。新项目只在有产物时建立必要目录：正式说明 / 研究 / 地图 / evidence 归现有 docs，代码和测试归其现有目录，临时与运行产物归明确的工作目录；不在项目根散落报告、导出、ZIP 或重复最终版。数据根独立时只记录位置，不复制数据。
- Owner 允许整理目录时，先写旧→新位置映射并检查路径引用、运行入口、配置与恢复方式。可以整理外层工作目录或无依赖的散落产物；包内布局、import、资源相对路径、数据库位置或构建输出不得仅为整齐搬动。涉及依赖的迁移先局部验证并建立保存点；不同时做目录大迁移和功能扩张。更新实际受影响的入口 / 地图，不默认重扫或生成完整文件清单。

## 对话、窗口与任务

- 默认一个项目工作对话即可混合提问、捕获想法、研究和施工；每条输入按实际内容处理，不把整个对话永久分类为“聊天”或“施工”。一般解释直接回答，只有需要持续跟踪的工作才建卡。
- 同一功能的澄清和排错留当前 Task；独立新能力先 Draft。Owner 明确要求先研究时，创建或复用一个有界研究 Task，不把所有潜在功能一次拆成正式施工卡。
- 默认一项正在施工的焦点；不要求常设主控窗口。独立研究确需另开窗口时，记录其 Task、允许读写范围、所依据版本与产物位置。两个窗口不同时改同一卡或同一文件；技术隔离用现有工具，未隔离就串行。
- Backlog 是共享工作记录，不是运行中的 Agent。网页保存、拖动或推广 Draft 不自动派发施工；除非 Owner 另行授权并实际配置执行集成。Agent 开始/恢复相关工作和写回卡片前读取最新相关卡，避免覆盖 Owner 的网页修改，不每轮刷新全看板。
- 接手先核对任务焦点与其他执行者、相关版本、证据范围及产物存在性。符合条件直接复用；变化只重验相关部分，关键缺口才阻塞相应施工。只读核对不会授予运行 Builder 或全量数据扫描权限。

## 任务生命周期

正常工作使用：

已授权的范围 → Backlog Task → 必要分析 / 计划 → 执行 → 验证 → Git 保存 → 必要时 Review → Done → 安全时同步 remote

- 随口想法、待评估提议进入 Backlog Draft；Draft 不授权施工。明确的研究请求可以建立研究 Task，但不授权生产化。
- Task 记录当前授权范围与验收条件。移动优先级或拖动卡片不自动扩大范围；按项目已约定的 Review 操作记录 Owner 验收。
- Review 用于确需 Owner 判断的结果、方向或约定验收，不是每张卡的固定停站。技术验证由 Agent 完成；不得替 Owner 宣布已接受，也不得将测试失败标成完成。
- 等待决定只暂停依赖该决定的工作。可以继续明确已授权且独立的任务；不得借机自行挑选新任务施工。
- Superpowers / Backlog 的通用流程服从 Owner 已明确的授权偏好：范围和方案未变时不重复审批，常规技术问题先自行排查；实际产品取舍、明显投入增加或无法安全继续时才询问。此约定不覆盖宿主权限限制。
- 必要计划使用 Backlog Implementation Plan，复杂设计或已有 Superpowers 计划可作为唯一链接附件；不再复制一份同内容计划。计划中的施工步骤不是第二套项目任务，不另维护其优先级、Owner 状态或看板。

## Git

当前项目不是 Git repository 时，初始化本地 Git。

已经存在 Git 时，先了解现状（不需要要求 Owner 理解这些概念）：

- 当前 branch
- working tree 是否有未保存修改
- 最近提交
- 是否存在 remote

### 保存点

- 不要按照"修改了几次文件"决定 commit。
- 以"有意义且已经验证的工作单元"作为 Git 保存点。
- 默认：一个完成并验证的 Backlog Task，至少对应一个可恢复的 Git commit。
- 任务较大时，可以建立中间 checkpoint commit。
- 暂停、切换工作或换 Agent 前主动保留可恢复中间结果；尚未验证的 checkpoint 明确标注“中间版本”，不冒充已验收。不要仅因为任务未 Done 就让重要研究结论长期没有保存点。
- Owner 不负责提醒 commit。完成一个可判断的成果、形成重要研究结论或需要安全暂停时由 Agent 检查保存条件并执行；普通问答和每次改 Draft 不机械提交。网页写盘、Git 保存、远端备份、数据运行检查点是四回事。
- Backlog autoCommit 只针对其任务文件变更，不等于保存全部代码或数据；首次接入核对现有配置。默认不新增逐操作自动提交、跳过 hooks 或卡片状态触发施工的自动化。

### 同步远端

Owner 不需要自己判断什么时候 push。

满足以下条件时，任务完成后可以正常 push：

- 当前任务已经完成并验证
- Git 状态明确
- remote 已经正常配置
- 不需要 force push
- 不存在未知冲突或危险操作
- 当前任务的同步已获授权或符合项目既定同步约定；内容适合该 remote，不含密钥、私有原始数据等不应上传的材料
- 目标确是 Owner 可用的同步位置；clone 他人项目的 origin 不自动成为 Owner 的备份目标

不满足时不要冒险 push，改用简单中文向 Owner 说明为什么暂时没有同步（遵循 owner-plain-language-zh）。

### 安全底线

不得：

- force push
- 擅自覆盖 remote
- 删除未知修改
- 在不理解 dirty state 的情况下提交
- 为了得到 clean working tree 而丢弃用户文件
- 为了"完成 push"而自动进行危险 merge、rebase、force push 或覆盖远端

## Backlog

- 项目尚未初始化 Backlog.md 时，使用 Backlog.md 官方方式初始化；已经存在 Backlog 时直接使用，不建立第二套任务系统。
- 先检查本机版本与帮助，按可用版本读取官方工作说明；不假设新命令或状态存在，不为遵守本 Skill 自动升级环境。Draft 使用工具实际支持的草稿机制；Review 对接项目已有状态，不把 Draft 强行当普通状态列。
- 任务通过 Backlog CLI / MCP / Web UI 管理，不要直接手工修改 Backlog 内部任务 Markdown。
- 不要为了"整理项目"自动生成几十张任务卡。只根据 Owner 当前要求、已经明确存在的问题、当前可执行工作，建立必要任务。

## Owner 可视化

- Backlog.md Web UI 是默认的项目任务可视化方式，Owner 想查看任务时优先使用它。
- 需要启动本地 UI 时，使用 Backlog.md 官方 browser 功能。
- 不要自己开发新的项目管理前端来替代 Backlog；不要因为没有运行 Web UI 就创建新的可视化系统。
- Owner 主要看 Board 与 Draft，All Tasks 用来检索，Statistics 只反映卡片统计，不等于产品完成比例。卡片优先写“影响哪个功能、要得到什么结果、是否待决定”，技术细节留正文。
- 功能 / 数据地图与任务看板不同：按需复用现有图或 Archify 等现成工具。只生成当前问题相关的阅读视图，不创建可执行节点编辑器、新主控或第二任务看板。详细边界见研究与数据参考。

## 已有未提交修改

接管项目时如果已经存在未提交修改：

- 视为用户已有工作，先识别和保护。
- 不要假定这些修改属于当前任务。
- 不要偷偷把未知修改混入新的任务 commit。
- 必要时先建立安全 checkpoint，但不得破坏已有状态。

## 研究 / 数据 / Skill 项目

本协议不只适用于传统代码项目，研究项目、数据项目和 Agent Skill 项目同样适用。

研究结果和 Skill 的长期有效内容应保存进项目文件并由 Git 管理，不要让聊天记录成为唯一保存位置。

研究按“问题、范围、允许改动的产物、完成条件”进入 Backlog。原始证据、分析、结论可在同一小文档分节；重要原始数据不强塞 Git，以可靠存储位置、版本与来源记录引用。一次执行成功不等于研究结论成立或数据质量通过。

遇到错误先说明影响哪个功能，再按现有调试方法修复。相同假设与相同输入没有新证据时不循环重试；保留失败结论和适用版本，缩小试验或改变假设。无法在批准边界内继续时，说明可保留什么、推荐回到哪一步和需要哪个决定，不擅自扩建系统。

## Handoff and Evidence

项目应支持不同 Agent、不同模型和新会话随时接手，接手状态不得依赖旧聊天。项目中的真实代码、测试、Git、Backlog 和长期文档始终高于 handoff 文件：handoff 是当前工作的快速恢复入口，不是第二份项目数据库，也不是完整历史档案。

### Handoff 文件

持续跨 Agent 工作的项目维护一个短的 rolling handoff 文件，默认 `docs/AI-HANDOFF.md`；项目已有等价 handoff 文件时继续使用现有文件，不创建第二份。新项目只有在确实需要持续跨 Agent 工作时才建立 handoff。

handoff 文件使用以下固定结构：

```markdown
# <Project> Handoff

## Current State
## Current Focus
## Last Meaningful Changes
## In Progress
## Open Decisions / Risks
## Verification Status
## Next Step
## Immediate First Action
```

每个 section 只写以下内容：

- **Current State**：用非常短的内容说明当前阶段、当前 Backlog Task（如有）、当前状态（进行中 / 等待 Owner / 被阻塞 / 可继续 / 已完成）、Git 是否已有可回滚保存点、是否存在 blocker。不复制完整 Backlog。
- **Current Focus**：当前真正正在解决的问题或目标。当前没有进行中的工作时明确写 None / 当前无进行中任务。
- **Last Meaningful Changes**：只写最近真正改变项目状态的内容。不写操作流水账；已经能从 Git diff 查到的大量细节不复制。
- **In Progress**：只列尚未完成的实际工作。没有就写 None。
- **Open Decisions / Risks**：等待 Owner 的决定或验收、当前 blocker、重要风险，以及下一 Agent 不应重复尝试的失败方向。没有就写 None。
- **Verification Status**：明确区分已验证 / 尚未验证 / 验证失败，引用已有的 Backlog Acceptance Criteria、evidence、tests、Git commit，不复制完整测试日志。
- **Next Step**：给 Owner 和 Agent 看的推荐下一步。默认只给一个最值得做的下一步；真有多个合理候选时最多给 3 个并按优先级排序。存在 In Progress 时通常优先继续它；当前工作等待 Owner 时，首先写清所需决定，不得越过它继续依赖该决定的施工；独立且已授权工作可继续。存在 blocker 时优先解除。不使用"继续项目""继续开发"这类空话。每次更新时刷新并删除过期推荐；推荐本身不授权执行。
- **Immediate First Action**：下一 Agent 接手后可以马上执行的一件事，例如查看 BACK-12 的验收条件、读取 docs/evidence/task-12/RESULT.md、等待 Owner 对 task-5 Review 的决定。不能写"继续开发""熟悉项目""看一下代码"这类空话；除非当前任务本身明确要求 inventory / audit，否则不得要求重新扫描整个仓库。

### Rolling Handoff Rules

创建：

- 已有等价 handoff 文件时继续使用，不创建第二份。
- 新项目只有在确实需要持续跨 Agent 工作时才建立 handoff；一次性任务不建立。

维护：

- 默认保持简短，目标约 40–80 行，不设机械硬限制。
- 这是 rolling summary，不是 session diary：过期状态直接替换，不要无限追加。
- 不重复 README、AGENTS.md、Backlog、Git history、完整 architecture 或完整 evidence，用引用代替复制。
- 只在重要节点更新：切换 Agent / 模型 / session 前、一个完整任务或阶段结束、当前目标改变、出现重要 blocker 或验证失败、Owner 要求暂停、发现下一 Agent 必须知道否则会重复工作的事实。不要每修改一个文件都更新。
- 更新后 Owner 应能快速看到 Current State 与 Next Step；不为 handoff 创建新的 Web UI，任务全貌仍使用 Backlog browser。
- Next Step 只是推荐下一步，不是第二套任务列表；长期任务仍然必须进入 Backlog。

### Authority

handoff 只是快速恢复入口。真实权威仍然是：

- Backlog：任务状态、验收条件、依赖。
- Git：实际发生的版本变化和回滚。
- Tests / Evidence：为什么可以说某项工作已完成。
- Durable docs / decisions：长期项目事实和冻结决定。
- 当前批准意图：Owner 要求什么、为什么、明确不做什么。实际代码 / 数据只证明现状，不能反过来授权需求变更；新且明确的 Owner 指令及时落盘，含糊提议不覆盖批准条款。

如果 handoff 与上述真实状态冲突，必须先核对并以实时可验证的项目状态为准，同时修正 handoff；不得盲信旧交接，也不得在错误假设上继续大规模施工。

### 接手项目时的读取顺序

新 Agent 接手项目时：

1. 先读取项目 AGENTS.md / 等价项目规则。
2. 再读取 handoff（默认 `docs/AI-HANDOFF.md`，或项目已有等价文件）：先看 Current State 与 Next Step，再按需读其他 section。
3. 查看当前 Backlog Task。
4. 检查实际 Git 状态，并与 handoff 的 Current State 中记录的 Git 保存点对照。
5. 阅读当前任务直接引用的批准意图条款、evidence / decision / docs；文件位置缺失时做定向查找，不全仓补 Spec。
6. 最后只读取完成当前任务必要的源码、数据或 Skill。

除非当前任务明确要求 inventory / audit / architecture review，禁止无目的地重新扫描完整仓库。

### Evidence

对于重要 Backlog Task，在任务准备被标记完成时保留最小可验证 Evidence。推荐：

```text
evidence/<TASK-ID>/
    RESULT.md
    <必要的测试 / 校验 / 截图 / 输出>
```

不要求每个任务都制造大量文件。RESULT.md 至少说明：Task ID、最终结果（PASS / FAIL / PARTIAL）、实际完成了什么、使用什么方式验证、关键产物、对应 Git commit（如有）、已知未完成或风险。

Evidence 是证明索引，不是项目副本：已经存在于测试、Git、正式数据或文档中的大型内容优先引用，不复制。

结果必须标明验证覆盖的是哪个产物 / 输入版本与范围；样本通过不代表全量通过。可以直接用任务已有结果摘要作索引，不为同一结论再造 RESULT.md。Git commit 引用被验证的实现版本；证据随后保存，不要求文档引用包含自身的最终 commit。版本、输入或关键配置改变时只重验受影响部分。

### Freeze Packages

不要为每一个普通 Backlog Task 创建 ZIP / freeze package。只在以下场景才考虑创建正式冻结包：正式里程碑接受、数据集 / Skill / contract 正式冻结版本、跨机器或脱离 repository 的正式交付、大规模破坏性清理前、Owner 明确要求独立审查包、接收方无法访问原 repository。

冻结包应包含 manifest 和必要 evidence，并能够说明它对应的 Git commit / Task / version。Git repository 本身仍然是日常版本历史的权威。

### 职责边界

- AGENTS.md 告诉 Agent 如何工作。
- Backlog 告诉 Agent 现在做什么。
- AI-HANDOFF.md 告诉新 Agent 上一棒停在哪里。
- Evidence 告诉 Agent 为什么可以相信上一棒的结论。
- Git 告诉 Agent 实际上发生过什么，并提供回滚能力。

这些职责不得互相复制或取代。

## 汇报与接管完成

所有 Owner-facing 的项目状态、Git 状态、问题解释和决策请求都遵循 owner-plain-language-zh；内部技术工作不受限制。

汇报项目或 Git 状态时，重点回答：发生了什么、有没有成功、能不能恢复、需不需要 Owner 操作。

项目首次接管完成后，Owner 至少应该能够知道：

- 当前项目是什么
- Backlog 是否可用
- 当前有哪些真正需要做的任务
- Git 是否已经保护项目
- 当前修改是否安全
- 是否已经存在远端备份
- 下一步是什么

不要为了展示专业性输出大量技术信息。
