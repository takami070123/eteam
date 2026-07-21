// Turbo(Rails)を読み込む
import "@hotwired/turbo-rails";

// Stimulusコントローラを読み込む
import "controllers";

// ページが読み込まれたときに実行
document.addEventListener("turbo:load", () => {

  // ===========================
  // HTMLの要素を取得
  // ===========================
  const input = document.getElementById("answer");   // 入力欄
  const word = document.getElementById("word");      // 問題表示
  const timer = document.getElementById("timer");    // タイマー表示
  const score = document.getElementById("score");    // スコア表示
  const wordsData = document.getElementById("words");// 単語一覧

  // 要素が存在しない場合は処理を終了
  if (!input || !wordsData) return;

  // ===========================
  // 単語一覧を取得
  // data-words属性に保存されているJSONデータを配列へ変換
  // ===========================
  const words = JSON.parse(wordsData.dataset.words);

  // ===========================
  // ゲームで使用する変数
  // ===========================
  let index = 0;      // 現在の問題番号
  let point = 0;      // スコア
  let miss = 0;       // ミス回数
  let remaining = 30;  // 残り時間（秒）

  // ===========================
  // 最初の問題を表示
  // ===========================
  word.textContent = words[index];

  // ===========================
  // 入力欄へ自動でカーソルを合わせる
  // ===========================
  input.focus();

  // 画面をクリックしても入力欄へ戻す
  document.addEventListener("click", () => {
    input.focus();
  });

  // ===========================
  // Escキーでゲーム中断
  // ===========================
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape") {
      if (confirm("ゲームを中断しますか？")) {
        // OKならトップページへ戻る
        window.location.href = "/";
      }
    }
  });

  // ===========================
  // タイマー処理
  // 1秒ごとに残り時間を減らす
  // ===========================
  const countdown = setInterval(() => {

    remaining--;
    timer.textContent = remaining;

    // 時間切れならゲーム終了
    if (remaining <= 0) {
      clearInterval(countdown);
      finishGame();
    }

  }, 1000);

  // ===========================
  // タイピング入力処理
  // ===========================
  input.addEventListener("input", () => {

    // アルファベットとハイフン以外は入力不可
    // 大文字は小文字へ変換
    input.value = input.value
      .replace(/[^a-zA-Z-]/g, "")
      .toLowerCase();

    // 現在のお題
    const correct = words[index];

    // ---------------------------
    // 入力途中の判定
    // ---------------------------
    if (!correct.startsWith(input.value)) {

      // 間違えた文字を削除
      input.value = input.value.slice(0, -1);

      // ミス回数を増やす
      miss++;

      return;
    }

    // ---------------------------
    // 単語を最後まで入力できた
    // ---------------------------
    if (input.value === correct) {

      // スコア100点追加
      point += 100;
      score.textContent = point;

      // 次の問題へ
      index++;

      // 最後まで行ったら最初へ戻る
      if (index >= words.length) {
        index = 0;
      }

      // 次のお題を表示
      word.textContent = words[index];

      // 入力欄を空にする
      input.value = "";

    }

  });

  // ===========================
  // ゲーム終了処理
  // ===========================
  function finishGame() {

    console.log("FINISH GAME CALLED");

    // サーバへ送信するデータを作成
    const formData = new FormData();
    formData.append("score", point);          // スコア
    formData.append("correct_count", index);  // 正解数
    formData.append("miss_count", miss);      // ミス回数

    // サーバへ結果を送信
    fetch("/finish", {
      method: "POST",
      body: formData
    })
    .then(response => {

      console.log("FETCH SUCCESS:", response.status);

      // 結果画面へ移動
      window.location.href = "/result";

    })
    .catch(err => {

      // 通信失敗時
      console.error("FETCH ERROR:", err);

    });
  }

});