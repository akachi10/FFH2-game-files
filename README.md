# FFH2-game-files · Magister Modmod 实际生效的游戏文件

《文明 4：超越刀锋》模组 **Magister Modmod for FfH2** 的运行目录快照，含简体中文汉化与一些自用的平衡性改造。

配套仓库：**[FFH2-chinese](https://github.com/akachi10/FFH2-chinese)** —— 汉化主线、改造台账、工具脚本都在那边。本仓库只管「实际装在游戏里的文件长什么样」。

## 这个仓库是干什么的

记录每一次改造落盘后的真实状态，一次改造一个提交，**提交信息对应台账里的「改造 N」编号**，两边可以互查。

| 提交 | 对应 |
|---|---|
| `e16de2b` | 改造 1–22 后的基线 |
| `03406db` | 改造 23：灰色议会惩罚调整 + 阿尔达退回整数运算 |

## 跟踪范围

只跟踪 `*.xml` / `*.py` / `*.ini` 三类文本配置，外加主 DLL。**不含** Art、res、sounds 等美术音效资源，也不含任何 `.bak-*` 备份——所以这**不是一份可以直接下载就玩的完整模组**，缺原版模组的资源文件。

想玩的话请先装原版 Magister Modmod，再用这里的文件覆盖。

`.gitattributes` 设了 `* -text` 关闭换行符自动转换：Civ4 的 XML/Python 全是 CRLF，被转成 LF 会让游戏解析异常。

## ⚠️ DLL 已打补丁

`Assets/CvGameCoreDLL.dll` **不是原版**，打过一处二进制补丁：

| 项 | 值 |
|---|---|
| 改动 | `CvPlot::calculateCulturalOwner()` 不再把宗主城市放进候选名单 |
| 效果 | 移除「附庸边境压制」，附庸的地块不会再被宗主吞并 |
| 偏移 | `0x207FFE`，共 **6 字节** |
| 补丁后 sha256 | `866597a31cf23c18944ca4df07010b960579fa51dc395ef918bad71c9a306876` |
| 原版 sha256 | `04eeb7bba7ca81ecbce2e4c0a92dbb44804db2271401b7fe2cffcf9e5686e21e` |

MM 只发布编译好的 DLL、不含源码，所以这项只能靠二进制补丁实现。带字节校验与 `--revert` 还原功能的脚本在 [FFH2-chinese 的 `MM玩法改造/tools/`](https://github.com/akachi10/FFH2-chinese/tree/master/MM玩法改造/tools) 里，想还原成原版可以自己跑。

**多人联机注意**：对方若用未打补丁的 DLL 会 OOS（不同步）。

## 汉化与改造

- **汉化**：`Assets/XML/Text/` 下的中文文本。适配英克（YK）官方简体中文版，安装说明见配套仓库。
- **平衡性改造**：23 项，作者自用口味，包括王宫强化、地图放大、史诗巢穴可重复探索、阿尔达判定调整等。完整清单见 [改造台账](https://github.com/akachi10/FFH2-chinese/blob/master/MM玩法改造/README.md)。

## 出处

- **Fall from Heaven 2** —— Kael 与 FfH 团队
- **Magister Modmod for FfH2** —— Magister Cultuum（基于 lfgr 的 MNAI-U）

原作与模组是 CivFanatics 社区的免费同人创作，版权归各自作者。这里只是汉化与个人向调整的留痕。
