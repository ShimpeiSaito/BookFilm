window.onload = Main;

function Main() {
  let app = new Vue({
    el: "#seat_form_app",
    data: {
      min: 99,
      max: 0,
      screen: screen,
      place: JSON.parse(placement), // 列:[先頭, 末尾, 先頭, 末尾, ...]]
      quantity: quantity, // 予約する座席数
      selected: {}, // 選択された座席（番号順にソート）
      reserved: JSON.parse(reserved) // 予約済みの席
    },
    created() {
      console.log(this.reserved)
      for(key in this.place) {
        let top = this.place[key].length - 1;
        if(this.place[key][0] < this.min) this.min = this.place[key][0];
        if(this.place[key][top] > this.max) this.max = this.place[key][top];
      }
    },
    methods: {
      array(m, n) {
        let arr = [];
        for(let i = m; i <= n; i++) {
          arr.push(i);
        }
        return arr;
      },
      onSale(row, num) {
        let arr = [];
        let line = this.place[row];
        for(let l = 0; l < line.length / 2; l++) {
          this.array(line[l*2], line[l*2 + 1]).forEach(e => {
            arr.push(e);
          });
        }
        return arr.includes(num);
      },
      ifReserved(row, num) {
        return this.reserved.includes(row + num);
      }
    },
    watch: {
      selected: function() {
        count = 0;
        for(key in this.selected) {
          if(this.selected[key]) {
            count++;
            if(count > this.quantity) {
              alert("座席は" + this.quantity + "つまでで選択してください。");
              document.getElementById("seat-" + key).checked = false;
              delete this.selected[key];
            }
          }
          else {
            delete this.selected[key];
          }
        }
      }
    }
  });
}