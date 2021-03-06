﻿@inherits AgileEAP.MVC.ViewEngines.Razor.WebViewPage
@{
    Layout = "../Shared/_Kendo.cshtml";
}
@using AgileEAP.MVC
@using AgileEAP.Core
@using AgileEAP.Core.Extensions
@using AgileEAP.Workflow.Enums
@using AgileEAP.Workflow.Domain;
@using AgileEAP.Plugin.Workflow.Models
@using Kendo.Mvc.UI
@Html.BuilderToolbar()
@(Html.Kendo().Grid<TraceLogModel>()
    .Name("Grid")
    .Columns(columns =>
    {
        columns.Bound(o => o.Message).Title("日志消息");
        //columns.Bound(o => o.ProcessInstName).Title("流程实例");
        // columns.Bound(o => o.ActivityInstName).Title("活动实例");
        columns.Bound(o => o.WorkItemName).Title("工作项");
        columns.Bound(o => o.Operator).Title("操作员");
        columns.Bound(o => o.ClientIP).Title("操作员IP");
        columns.Bound(o => o.CreateTime).Format("{0:yyyy-MM-dd HH:mm:ss}").Title("操作时间");
    })
    .Pageable(o =>
    {
        o.PageSizes(new int[] { 10, 15, 20 });
        o.Messages(m => { m.ItemsPerPage("项每页"); });
    })
    .Sortable()
    .Filterable()
    .DataSource(dataSource => dataSource
        .Ajax()
        .Read(read => read.Action("TraceLog_Filter", "Monitor")).PageSize(Configure.Get<int>("PageSize", 15))
    )
)