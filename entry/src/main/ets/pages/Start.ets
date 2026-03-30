import { router } from '@kit.ArkUI';
import { SAFE_TOP } from '../constants/Index';

@Entry
@Component
struct Start {
  @StorageProp(SAFE_TOP) safeTop: number = 0;
  router = this.getUIContext().getRouter();
  // 定时器 id
  timerId: number = 0;

  aboutToAppear(): void {
    // 5 秒后自动跳转到首页
    this.timerId = setTimeout(() => {
      this.router.replaceUrl({ url: 'pages/Index' });
    }, 5000);
  }

  aboutToDisappear() {
    // 清除定时器
    if (this.timerId !== 0) {
      clearTimeout(this.timerId);
      this.timerId = 0;
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image($r('app.media.ad'))
      Button('<跳过>')
        .margin({ top: this.safeTop + 10, right: 10 })
        .backgroundColor('#4d000000')
        .onClick(() => {
          // 清除定时器后再跳转
          if (this.timerId !== 0) {
            clearTimeout(this.timerId);
            this.timerId = 0;
          }
          router.replaceUrl({ url: 'pages/Index' }).catch((err: Error) => {
            console.error('跳转失败:', err);
          });
        })
    }
  }
}
