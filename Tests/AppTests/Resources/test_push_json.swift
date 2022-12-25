let TEST_PUSH_JSON = """
{
  "tags": [
    {
      "id": "85bbe478-df84-410f-8d4c-72b71a17a8a4",
      "name": "第1章 Vaporとは",
      "commits": [
        {
          "id": "53d53d49-2f9f-4720-a433-7a93913ac951",
          "message": "Vaporは、Server-Side Swiftのフレームワークです。",
          "files": [
            {
              "name": "index.html",
              "type": "text",
              "content": "<h1>Hello, Vapor!</h1>"
            },
            {
              "name": "vapor_picture.png",
              "type": "image",
              "content": "vapor_picture"
            }
          ]
        },
        {
          "id": "e61561a5-91cc-4899-8177-4b4d1997f96d",
          "message": "vapor newでプロジェクトを作ってみましょう",
          "files": [
            {
              "name": "index.html",
              "type": "text",
              "content": "<h1>Hello, Vapor!</h1><h2>Vaporとは</h2>"
            },
            {
              "name": "about_vapor.jpeg",
              "type": "image",
              "content": "about_vapor"
            }
          ]
        }
      ]
    },
    {
      "id": "4b72b36c-351a-461a-a850-ada581bd9979",
      "name": "第2章 VaporのRouting",
      "commits": [
        {
          "id": "41d07f6e-5d1f-4102-b7c5-ce7d2861567a",
          "message": "ルーティングとは、リクエストのパスに応じてどの関数を仕様してレスポンスを返すかを登録するものです",
          "files": [
            {
              "name": "routes.swift",
              "type": "text",
              "content": "<h2>Vapor Routing</h2>"
            }
          ]
        },
        {
          "id": "45f24342-4d85-4c94-b873-6605b5ac3522",
          "message": "Vaporでルーティング処理を行なって、ブラウザでアクセスしてみます。",
          "files": [
            {
              "name": "browser.png",
              "type": "image",
              "content": "Browser Safari"
            }
          ]
        }
      ]
    }
  ]
}
"""
