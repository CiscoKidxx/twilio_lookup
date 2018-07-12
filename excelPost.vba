Private Sub Worksheet_Calculate()

    Dim target As Range
    Set target = Range("phoneNumber")

    Dim target1 As Range
    Set target1 = Range("ekdPhoneNumber")

      Dim xmlhttp As New MSXML2.xmlhttp, myurl As String, carrier As String

      If Not Intersect(target, Range("phoneNumber")) Is Nothing Then
        If Range("phoneNumber").Value <> "" Then
          myurl = "https://koxqv3ev1a.execute-api.us-east-1.amazonaws.com/dev/lookup/" & Range("phoneNumber").Value
          xmlhttp.Open "POST", myurl, False
          xmlhttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
          xmlhttp.Send ""
          carrier = Replace(xmlhttp.responseText, Chr(34), vbNullString)
          If carrier = "unknown" Then
              carrier = "XO Communications"
              Range("carrier").Value = carrier
          Else
              Range("carrier").Value = carrier
          End If
        Else
            Range("carrier").Value = ""
        End If
      End If

      If Not Intersect(target1, Range("ekdPhoneNumber")) Is Nothing Then
        If Range("ekdPhoneNumber").Value <> "" Then
          myurl = "https://koxqv3ev1a.execute-api.us-east-1.amazonaws.com/dev/lookup/" & Range("ekdPhoneNumber").Value
          xmlhttp.Open "POST", myurl, False
          xmlhttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
          xmlhttp.Send ""
          carrier = Replace(xmlhttp.responseText, Chr(34), vbNullString)
          If carrier = "unknown" Then
              carrier = "XO Communications"
              Range("ekdCarrier").Value = carrier
          Else
              Range("ekdCarrier").Value = carrier
          End If
        Else
            Range("ekdCarrier").Value = ""
        End If
      End If
      
End Sub
