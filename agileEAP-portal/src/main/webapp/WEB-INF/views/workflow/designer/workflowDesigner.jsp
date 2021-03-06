﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<title>流程设计器</title>
<link href="${ctx}/themes/default/tab.css" rel="stylesheet">
<link href="${ctx}/themes/default/jquery-ui.custom.css" rel="stylesheet">
<link href="${ctx}/js/contextMenu/jquery.contextMenu.css" rel="stylesheet"	type="text/css" />
<link href="${ctx}/themes/default/workflowDesigner/workflowDesigner.css" rel="stylesheet">

<script src="${ctx}/js/jquery.contextMenu.js"	type="text/javascript"></script>
<script src="${ctx}/js/tab/tab.js"	type="text/javascript"></script>
<script src="${ctx}/js/jquery-ui.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/jsplumb/jsPlumb-1.3.14-all-min.js"></script>
<script type="text/javascript" src="${ctx}/js/workflow/workflowDesigner.js"></script>

    <script type="text/javascript">
        $(window).resize(function () {
            resizeWindow();
        });
        $(document).ready(function () {
            switchTab("workflow");
            resizeWindow();
            if (WorkflowDesigner) {
                WorkflowDesigner.init("${ctx}/workflow/designer/getProcessInfo", $.query.get("processDefID"), null, "designer_content", 1, "${ctx}/workflow/designer/getProcessDef");
            }
        });
        function resizeWindow() {
            var windowHeight = getWindowHeight();
            if (windowHeight == 0) return;
            document.getElementById("mainbody").style.height = windowHeight - $("#header").height() - 8 + "px";
            document.getElementById("main_leftcontent").style.height = windowHeight - $("#header").height() - 8 + "px";
            document.getElementById("main_designercontent").style.height = windowHeight - $("#header").height() - 8 + "px";
            document.getElementById("toolbox_content").style.height = windowHeight - $("#header").height() - 61 + "px";
            document.getElementById("designer_content").style.height = windowHeight - $("#header").height() - 130 + "px";
            document.getElementById("XMLdesigner_content").style.height = windowHeight - $("#header").height() - 130 + "px";

            document.getElementById("main_leftcontent").style.width = "80px";
            document.getElementById("main_attributecontent").style.width = "226px";
            document.getElementById("designer_content").style.width = document.body.offsetWidth - $("#main_leftcontent").width() - $("#main_attributecontent").width() - 58 + "px";
            document.getElementById("XMLdesigner_content").style.width = document.body.offsetWidth - $("#main_leftcontent").width() - $("#main_attributecontent").width() - 58 + "px";
            document.getElementById("designer_title").style.width = document.body.offsetWidth - $("#main_leftcontent").width() - $("#main_attributecontent").width() - 7 + "px";
            document.getElementById("main_designercontent").style.width = document.body.offsetWidth - $("#main_leftcontent").width() - $("#main_attributecontent").width() - 7 + "px";
            document.getElementById("main_attributecontent").style.height = windowHeight - $("#header").height() - 8 + "px";
            document.getElementById("attribute_content").style.height = windowHeight - $("#header").height() - 61 + "px";
        }
        function Designer(me) {
            switch (me.id) {
                case "view":
                    if ($(me).parent().attr("class").indexOf("ui-tabs-selected") < 0) {
                        var ID = processDefine.ID;
                        if ($.query.get("processDefID")) {
                            ID = $.query.get("processDefID");
                        }
                        WorkflowDesigner.draw("${ctx}/workflow/designer/getProcessDefine", $("#XMLdesigner_content").val(), "designer_content");
                    } break;
                case "XML":
                    if ($(me).parent().attr("class").indexOf("ui-tabs-selected") < 0) {
                        WorkflowDesigner.reloadXML("${ctx}/workflow/designer/getProcessDefContent");
                    } break;
            }

        }
    </script>
</head>
<body>
    <div id="page" style="position: relative;">
        <div id="header">
            <div id="menus">
                <ul id="header_menu">
                    <li id="header_menu_file" class="menu">文件(F)</li>
                    <li id="header_menu_edit" class="menu">编辑(E)</li>
                    <li id="header_menu_view" class="menu">视图(V)</li>
                    <li id="header_menu_data" class="menu">数据(D)</li>
                    <li id="header_menu_window" class="menu">窗口(w)</li>
                    <li id="header_menu_help" class="menu">帮助(H)</li>
                </ul>
            </div>
            <div id="toolbars">
                <ul id="header_toolbar">
                    <li id="header_toolbar_new" class="toolbar">
                        <img src="${ctx}/themes/default/workflowDesigner/images/New.gif" alt="新建" />
                    </li>
                    <li id="header_toolbar_open" class="toolbar">
                        <img src="${ctx}/themes/default/workflowDesigner/images/Open.png" alt="打开" />
                    </li>
                    <li id="header_toolbar_save" class="toolbar">
                        <img src="${ctx}/themes/default/workflowDesigner/images/Save.png" alt="保存" />
                    </li>
                    <li id="header_toolbar_back" class="toolbar">
                        <img src="${ctx}/themes/default/workflowDesigner/images/Undo.gif" alt="退后一步" />
                    </li>
                    <li id="header_toolbar_redo" class="toolbar">
                        <img src="${ctx}/themes/default/workflowDesigner/images/Redo.gif" alt="前进" />
                    </li>
                    <li id="header_toolbar_zoomenlarge" class="toolbar">
                        <img src="${ctx}/themes/default/workflowDesigner/images/ZoomEnlarge.gif"
                            alt="放大" />
                    </li>
                    <li id="header_toolbar_zoomdecrease" class="toolbar">
                        <img src="${ctx}/themes/default/workflowDesigner/images/ZoomDecrease.gif"
                            alt="缩小" />
                    </li>
                    <li id="header_toolbar_zoomscale" class="toolbar">
                        <select id="sel_zoomscale" style="width: 100px;" class="ui-wizard-content valid">
                            <option value="100%">100%</option>
                            <option value="200%">200%</option>
                            <option value="300%">300%</option>
                            <option value="90%">90%</option>
                            <option value="70%">70%</option>
                            <option value="50%">50%</option>
                        </select>
                    </li>
                    <li id="header_toolbar_drawLine" class="toolbar">
                        <img src="${ctx}/themes/default/workflowDesigner/images/Polyline.png" alt="选择连线" />
                    </li>
                    <li id="header_toolbar_left" class="toolbar">
                        <img src="${ctx}/themes/default/workflowDesigner/images/position/left.png"
                            alt="居左" />
                    </li>
                    <li id="header_toolbar_center" class="toolbar">
                        <img src="${ctx}/themes/default/workflowDesigner/images/position/center.png"
                            alt="居中" />
                    </li>
                    <li id="header_toolbar_right" class="toolbar">
                        <img src="${ctx}/themes/default/workflowDesigner/images/position/right.png"
                            alt="居右" />
                </ul>
            </div>
        </div>
        <div id="mainbody">
            <div id="main_leftcontent">
                <div id="toolbox_title">工具箱</div>
                <div id="toolbox_ativities">
                    <img id="toolboxshow" src="${ctx}/themes/default/workflowDesigner/images/Show.jpg"
                        style="float: left" /><label style="height: 25px; line-height: 25px;">活动</label>
                </div>
                <ul id="toolbox_content">
                    <li class="ativity" id="StartActivity">
                        <img src="${ctx}/themes/default/workflowDesigner/images/StartActivity.png"
                            class="ativityImg" /><label class="toolbox_content_title">开始活动
                            </label>
                    </li>
                    <li class="ativity" id="ManualActivity">
                        <img src="${ctx}/themes/default/workflowDesigner/images/ManualActivity.png"
                            class="ativityImg" /><label class="toolbox_content_title">人工活动
                            </label>
                    </li>
                    <li class="ativity" id="RouterActivity">
                        <img src="${ctx}/themes/default/workflowDesigner/images/RouterActivity.png"
                            class="ativityImg" /><label class="toolbox_content_title">路由活动
                            </label>
                    </li>
                    <li class="ativity" id="AutoActivity">
                        <img src="${ctx}/themes/default/workflowDesigner/images/AutoActivity.png"
                            class="ativityImg" /><label class="toolbox_content_title">自动处理
                            </label>
                    </li>
                    <li class="ativity" id="SubflowActivity">
                        <img src="${ctx}/themes/default/workflowDesigner/images/SubflowActivity.png"
                            class="ativityImg" /><label class="toolbox_content_title">子流程
                            </label>
                    </li>
<%--                     @* <li class="ativity" id="ProcessActivity">
                        <img src="${ctx}/themes/default/workflowDesigner/images/ProcessActivity.png"
                            class="ativityImg" /><label class="toolbox_content_title">处理
                            </label>
                    </li>*@ --%>
                    <li class="ativity" id="EndActivity">
                        <img src="${ctx}/themes/default/workflowDesigner/images/EndActivity.png"
                            class="ativityImg" /><label class="toolbox_content_title">结束活动
                            </label>
                    </li>
                </ul>
            </div>
            <div id="main_designercontent">
                <ul id="tabcontainer">
                    <li id="workflow" class="tabBg1" onclick="switchTab('workflow');">新建</li>
                </ul>
                <div id="designer_title">流程图</div>
                <div id="tabs" class="tabs-bottom">
                    <ul>
                        <li><a id="view" onclick="Designer(this)" href="#designer_content">视图</a></li>
                        <li><a id="XML" onclick="Designer(this)" href="#XMLdesigner_content">XML文件</a></li>
                    </ul>
                    <div class="tabs-spacer"></div>
                    <div id="designer_content"></div>
                    <textarea id="XMLdesigner_content"></textarea>
                </div>
            </div>
            <div id="main_attributecontent">
                <div id="attribute_title">属性</div>
                <div id="attribute_ativity"><img src="${ctx}/themes/default/workflowDesigner/images/flowChart.png" />流程图属性</div>
                <div id="attribute_content">
                    <table style="width: 100%">
                        <tr>
                            <td>名称</td>
                            <td>
                                <input id="processName" type="text" value="processName" class="attribute" />
                            </td>
                        </tr>
                        <tr>
                            <td>显示名</td>
                            <td>
                                <input id="processText" type="text" value="显示名称" class="attribute" /></td>
                        </tr>
                        <tr>
                            <td>启动页面</td>
                            <td>
                                <input id="starturl" type="text" value="workflow/eform" class="attribute" />
                            </td>
                        </tr>
                        <tr>
                            <td>当前状态</td>
                            <td>
                                <select id="currentStatus">
                                    <option value="0">未发布</option>
                                    <option value="1">已发布</option>
                                    <option value="2">终止</option>
                                </select></td>
                        </tr>
                        <tr>
                            <td>版本</td>
                            <td>
                                <input id="version" type="text" value="1.0" class="attribute" /></td>
                        </tr>
                        <tr>
                            <td>描述</td>
                            <td>
                                <input id="description" type="text" value="" class="attribute" /></td>
                        </tr>
                        <tr>
                            <td>流程启动者</td>
                            <td>
                                <input id="startor" type="text" value="" class="attribute" /></td>
                        </tr>
                        <tr>
                            <td>所属分类</td>
                            <td>
                                <input id="categoryID" type="text" value="" class="attribute" /></td>
                        </tr>
                        <tr>
                            <td>是否当前版本</td>
                            <td>
                                <select id="currentFlag">
                                    <option value="1">是</option>
                                    <option value="0">否</option>
                                </select></td>
                        </tr>
                        <tr>
                            <td>是否活动实例</td>
                            <td>
                                <select id="isActive">
                                    <option value="1">是</option>
                                    <option value="0">否</option>
                                </select></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="header_menu_file_list" style="display: none" class="menuedit">
        <ul>
            <li id="filemenu_new" style="cursor: pointer" class="filemenu">新建</li>
            <li id="filemenu_open" style="cursor: pointer" class="filemenu">打开</li>
            <li id="filemenu_save" style="cursor: pointer" class="filemenu">保存</li>
            <li id="filemenu_close" style="cursor: pointer" class="filemenu">关闭</li>
            <li id="filemenu_exit" style="cursor: pointer" class="filemenu">退出</li>
        </ul>
    </div>
    <div id="header_menu_edit_list" style="display: none" class="menuedit">
        <ul>
            <li id="editmenu_undo" style="cursor: pointer" class="editmenu">后退</li>
            <li id="editmenu_redo" style="cursor: pointer" class="editmenu">前进</li>
            <li id="editmenu_cut" style="cursor: pointer" class="editmenu">剪切</li>
            <li id="editmenu_copy" style="cursor: pointer" class="editmenu">复制</li>
            <li id="editmenu_paste" style="cursor: pointer" class="editmenu">黏贴</li>
            <li id="editmenu_del" style="cursor: pointer" class="editmenu">删除</li>
        </ul>
    </div>
    <div id="header_menu_view_list" style="display: none" class="menuedit">
        <ul>
            <li id="viewmenu_toolbar" style="cursor: pointer" class="viewmenu">工具栏</li>
            <li id="viewmenu_toolbox" style="cursor: pointer" class="viewmenu">工具箱</li>
            <li id="viewmenu_designer" style="cursor: pointer" class="viewmenu">设计窗口</li>
            <li id="editmenu_attribute" style="cursor: pointer" class="viewmenu">属性窗口</li>
        </ul>
    </div>
    <div id="header_menu_data_list" style="display: none" class="menuedit">
        <ul>
            <li id="datamenu_import" style="cursor: pointer" class="datamenu">导入</li>
            <li id="datamenu_outport" style="cursor: pointer" class="datamenu">导出</li>
        </ul>
    </div>
    <div id="header_menu_window_list" style="display: none" class="menuedit">
        <ul>
            <li id="windowmenu_split" style="cursor: pointer" class="windowmenu">拆分</li>
            <li id="windowmenu_closeall" style="cursor: pointer" class="windowmenu">关闭所有</li>
        </ul>
    </div>
    <div id="header_menu_help_list" style="display: none" class="menuedit">
        <ul>
            <li id="helpmenu_helpdocument" style="cursor: pointer" class="helpmenu">帮助文档</li>
            <li id="helpmenu_about" style="cursor: pointer" class="hepmenu">关于</li>
        </ul>
    </div>
    <div id="contexmenu" style="display: none">
        <ul>
            <li id="contexmenu_del" style="cursor: pointer">删除</li>
            <li id="contexmenu_copy" style="cursor: pointer">复制</li>
        </ul>
    </div>
    <div id="linestyle" style="display: none">
        <ul>
            <li id="linestyle_straight" class="line" style="cursor: pointer">直线</li>
            <li id="linestyle_flowchart" class="line" style="cursor: pointer">流程线</li>
            <li id="linestyle_bezier" class="line" style="cursor: pointer">曲线</li>
        </ul>
    </div>
    <ul id="ulcontrol" class="contextMenu" style="font-size: 12px;">
        <li class="delcontrol"><a href="#delControl">删除</a></li>
        <li class="cutcontrol"><a href="#cutControl">剪切</a></li>
        <li class="copycontrol"><a href="#copyControl">复制</a></li>
        <li class="formcontrol"><a href="#formControl">表单</a></li>
        <li class="attrcontrol"><a href="#attrControl">属性</a></li>
    </ul>
    <ul id="ulline" class="contextMenu" style="font-size: 12px;">
        <li class="delcontrol"><a href="#delControl">删除</a></li>
        <li class="attrcontrol"><a href="#attrControl">属性</a></li>
    </ul>
    <ul id="uldocument" class="contextMenu" style="font-size: 12px;">
        <li class="pastecontrol"><a href="#pasteControl">黏贴</a></li>
    </ul>
    <div id="actionDialog" style="height: 0px; border: 0px; overflow: hidden; font-size: 0px;">
    </div>
    <div id="processbar" style="height: 0px; border: 0px; overflow: hidden; font-size: 0px;">
    </div>
</body>
</html>
