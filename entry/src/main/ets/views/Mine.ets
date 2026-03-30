import { getSongList } from '../apis/Index';
import { SongItemType, SongItem } from '../models/Index';

@Component
export default struct Mine {
  @State showList: [SongItemType[]] = [[]];
  columnList: number[] = [0, 1, 2, 3];

  async aboutToAppear() {
    const songList: SongItemType[] = await getSongList() as SongItemType[];
    this.columnList.forEach(item => {
      this.showList[item] = songList.map(item => new SongItem(item))
        .sort(() => Math.random() - 0.5);
    });
  }

  build() {
    Column() {
      // 个人信息区域
      Column() {
        // 头像和信息
        Row({ space: 16 }) {
          // 头像
          Column() {
            Image($r('app.media.logo'))
              .width(70)
              .height(70)
              .borderRadius(35)
              .objectFit(ImageFit.Cover)
          }
          .width(80)
          .height(80)
          .backgroundColor('#2a2a2e')
          .borderRadius(40)

          // 信息
          Column({ space: 8 }) {
            Row({ space: 8 }) {
              Text('黑马云音乐')
                .fontColor(Color.White)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
              Image($r('app.media.ic_vip'))
                .width(32)
                .height(32)
            }
            .justifyContent(FlexAlign.Start)

            Row({ space: 12 }) {
              Row({ space: 4 }) {
                Image($r('app.media.ic_boy'))
                  .width(12)
                  .height(12)
                  .fillColor('#ff6b8b')
                Text('00 后')
                  .fontColor('#999')
                  .fontSize(12)
              }
              Row({ space: 4 }) {
                Text('双子座')
                  .fontColor('#999')
                  .fontSize(12)
              }
              Row({ space: 4 }) {
                Text('北京')
                  .fontColor('#999')
                  .fontSize(12)
              }
            }

            Row({ space: 16 }) {
              Column() {
                Text('1')
                  .fontColor(Color.White)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                Text('关注')
                  .fontColor('#666')
                  .fontSize(11)
              }
              Column() {
                Text('10 万')
                  .fontColor(Color.White)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                Text('粉丝')
                  .fontColor('#666')
                  .fontSize(11)
              }
              Column() {
                Text('167 万')
                  .fontColor(Color.White)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                Text('赞')
                  .fontColor('#666')
                  .fontSize(11)
              }
            }
            .margin({ top: 4 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .padding(20)
        .width('100%')
      }
      .width('100%')
      .backgroundColor('#1a1a1e')

      // 歌单区域
      Column() {
        GridRow({ gutter: 8 }) {
          ForEach(this.columnList, (item: number) => {
            GridCol({ span: 6 }) {
              SongCard({ songs: this.showList[item] })
            }
          })
        }
        .padding({ left: 8, right: 8, top: 8 })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#0d0d0f')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct SongCard {
  @Prop songs: SongItemType[] = [];

  build() {
    Column() {
      Text('我的歌单')
        .fontColor('#fff')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })
        .padding({ bottom: 8 })
        .borderWidth({ bottom: 2 })
        .borderColor('#e9608b')

      List({ space: 10 }) {
        ForEach(this.songs, (item: SongItemType, index: number) => {
          ListItem() {
            Row({ space: 10 }) {
              // 序号
              Text((index + 1).toString())
                .fontColor('#666')
                .fontSize(13)
                .width(20)
                .textAlign(TextAlign.Center)

              // 歌曲封面
              Image(item.img)
                .width(45)
                .height(45)
                .borderRadius(6)
                .objectFit(ImageFit.Cover)

              // 歌曲信息
              Column({ space: 4 }) {
                Text(item.title)
                  .fontColor('#f4f4f6')
                  .fontSize(13)
                  .fontWeight(FontWeight.Medium)
                  .maxLines(1)

                Text(item.artist)
                  .fontColor('#888')
                  .fontSize(11)
                  .maxLines(1)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              // 播放按钮
              Image($r('app.media.ic_single_play'))
                .width(20)
                .height(20)
                .fillColor('#e9608b')
            }
            .alignItems(VerticalAlign.Center)
            .padding({ top: 10, bottom: 10 })
            .borderWidth({ bottom: 1 })
            .borderColor('#1f1f23')
          }
        })

        ListItem() {
          Row() {
            Text('共 ' + this.songs.length.toString() + ' 首歌曲')
              .fontColor('#555')
              .fontSize(11)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: 12, bottom: 8 })
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .padding(10)
    .backgroundColor('#1a1a1e')
    .borderRadius(12)
  }
}
