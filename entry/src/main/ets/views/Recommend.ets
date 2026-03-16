@Component
export default struct Recommend {   //默认只有一个default
  build() {
    Column() {
      Text('推荐内容')
        .fontColor('#fff')
    }
    .width('100%')
    .height('100%')
  }
}