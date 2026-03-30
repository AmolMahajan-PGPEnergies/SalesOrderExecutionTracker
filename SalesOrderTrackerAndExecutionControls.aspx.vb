Imports System.Data
Imports System.Web
Imports System.Web.UI
Imports System.Web.Script.Serialization

Namespace SalesOrderExecutionTracker

    Public Partial Class SalesOrderTrackerAndExecutionControls
        Inherits Page

        Private ReadOnly _ser As New JavaScriptSerializer()

        ' ── ViewState keys ─────────────────────────────────────────────
        Private Const VS_SHIPMENTS   As String = "dtShipments"
        Private Const VS_CHECKPOINTS As String = "dtCheckpoints"
        Private Const VS_LAST_SAVED  As String = "cpLastSaved"

        ' ── Properties injected into page JS via <%=...%> ──────────────
        Protected ReadOnly Property InitialShipments As String
            Get
                Dim dt As DataTable = TryCast(ViewState(VS_SHIPMENTS), DataTable)
                If dt Is Nothing OrElse dt.Rows.Count = 0 Then Return "[]"
                Return ShipmentsTableToJson(dt)
            End Get
        End Property

        Protected ReadOnly Property InitialCheckpoints As String
            Get
                Dim dt As DataTable = TryCast(ViewState(VS_CHECKPOINTS), DataTable)
                If dt Is Nothing OrElse dt.Rows.Count = 0 Then Return "[]"
                Return CheckpointsTableToJson(dt)
            End Get
        End Property

        ' ── Page Load ──────────────────────────────────────────────────
        Protected Sub Page_Load(sender As Object, e As EventArgs)
            ' ViewState is restored automatically by ASP.NET on every postback.
            ' On first load (Not IsPostBack) both DataTables will be Nothing → "[]".
        End Sub

        ' ── Save handler — fired async by UpdatePanel ──────────────────
        Protected Sub btnSave_Click(sender As Object, e As EventArgs)
            Dim shipmentsJson   As String = hfShipments.Value
            Dim checkpointsJson As String = hfCheckpoints.Value

            ViewState(VS_SHIPMENTS)   = BuildShipmentsTable(shipmentsJson)
            ViewState(VS_CHECKPOINTS) = BuildCheckpointsTable(checkpointsJson)
            ViewState(VS_LAST_SAVED)  = DateTime.UtcNow.ToString("o")
        End Sub

        ' ── Build DataTable from JSON ───────────────────────────────────

        ''' <summary>
        ''' Shipments DataTable columns:
        '''   ShipmentId | ShipmentType | TimelineJson
        ''' TimelineJson stores the stage array as a JSON string.
        ''' </summary>
        Private Function BuildShipmentsTable(json As String) As DataTable
            Dim dt As New DataTable("Shipments")
            dt.Columns.Add("ShipmentId",   GetType(String))
            dt.Columns.Add("ShipmentType", GetType(String))
            dt.Columns.Add("TimelineJson", GetType(String))

            If String.IsNullOrWhiteSpace(json) OrElse json.Trim() = "[]" Then Return dt

            Try
                Dim list = _ser.Deserialize(Of List(Of Dictionary(Of String, Object)))(json)
                For Each item In list
                    Dim row As DataRow = dt.NewRow()
                    row("ShipmentId")   = GetStr(item, "id")
                    row("ShipmentType") = GetStr(item, "type")
                    row("TimelineJson") = If(item.ContainsKey("timeline"),
                                            _ser.Serialize(item("timeline")),
                                            "[]")
                    dt.Rows.Add(row)
                Next
            Catch ex As Exception
                ' Return empty table if JSON is malformed
            End Try
            Return dt
        End Function

        ''' <summary>
        ''' Checkpoints DataTable columns:
        '''   CpId | CpName | CpType | CpDescription
        ''' </summary>
        Private Function BuildCheckpointsTable(json As String) As DataTable
            Dim dt As New DataTable("Checkpoints")
            dt.Columns.Add("CpId",          GetType(String))
            dt.Columns.Add("CpName",        GetType(String))
            dt.Columns.Add("CpType",        GetType(String))
            dt.Columns.Add("CpDescription", GetType(String))

            If String.IsNullOrWhiteSpace(json) OrElse json.Trim() = "[]" Then Return dt

            Try
                Dim list = _ser.Deserialize(Of List(Of Dictionary(Of String, Object)))(json)
                For Each item In list
                    Dim row As DataRow = dt.NewRow()
                    row("CpId")          = GetStr(item, "id")
                    row("CpName")        = GetStr(item, "name")
                    row("CpType")        = GetStr(item, "type")
                    row("CpDescription") = GetStr(item, "description")
                    dt.Rows.Add(row)
                Next
            Catch ex As Exception
                ' Return empty table if JSON is malformed
            End Try
            Return dt
        End Function

        ' ── Serialize DataTables back to JSON for page injection ────────

        Private Function ShipmentsTableToJson(dt As DataTable) As String
            Dim list As New List(Of Dictionary(Of String, Object))
            For Each row As DataRow In dt.Rows
                Dim item As New Dictionary(Of String, Object)
                item("id")       = row("ShipmentId").ToString()
                item("type")     = row("ShipmentType").ToString()
                item("timeline") = _ser.Deserialize(Of Object)(
                                       If(row("TimelineJson").ToString(), "[]"))
                list.Add(item)
            Next
            Return _ser.Serialize(list)
        End Function

        Private Function CheckpointsTableToJson(dt As DataTable) As String
            Dim list As New List(Of Dictionary(Of String, Object))
            For Each row As DataRow In dt.Rows
                Dim item As New Dictionary(Of String, Object)
                item("id")          = row("CpId").ToString()
                item("name")        = row("CpName").ToString()
                item("type")        = row("CpType").ToString()
                item("description") = row("CpDescription").ToString()
                list.Add(item)
            Next
            Return _ser.Serialize(list)
        End Function

        ' ── Helper ─────────────────────────────────────────────────────
        Private Shared Function GetStr(dict As Dictionary(Of String, Object),
                                       key  As String) As String
            If dict.ContainsKey(key) AndAlso dict(key) IsNot Nothing Then
                Return dict(key).ToString()
            End If
            Return ""
        End Function

    End Class

End Namespace
