#### 1. 通过 vue init webpack 名字打下来的包不能直接打开浏览器
    需在config文件下的index.js修改 autoOpenBrowser: true

#### 2. 通过npm run build 打的dist压缩包需要放到服务器上
    npm install -g http-server
    然后在对应目录用命令行输入http-server就可以看到类似http://localhost:8081的可访问地址，在浏览器访问就好了

#### 3. vue侦听属性和方法的区别
    vue侦听属性有缓存，只有数据发生改变的时候才会再次调用该方法，渲染的时候会调用方法
    我们为什么需要缓存？假设我们有一个性能开销比较大的计算属性 A，它需要遍历一个巨大的数组并做大量的计算。然后我们可能有其他的计算属性依赖于 A 。如果没有缓存，我们将不可避免的多次执行 A 的 getter！如果你不希望有缓存，请用方法来替代。

#### 4. 为什么切换元素的时候上一个元素输入的值还可以在这个元素上显示，key管理可复用元素
    Vue 会尽可能高效地渲染元素，通常会复用已有元素而不是从头开始渲染。
    这么做除了使 Vue 变得非常快之外，还有其它一些好处。
    例如，如果你允许用户在不同的登录方式之间切换：

    <template v-if="loginType === 'username'">
    <label>Username</label>
    <input placeholder="Enter your username">
    </template>
    <template v-else>
    <label>Email</label>
    <input placeholder="Enter your email address">
    </template>
    要想不使用复用的元素增加key标识

#### 5. props 和 事件声明
    Vue.component('blog-post', {
    // 在 JavaScript 中是 camelCase 的
    props: ['postTitle'],
    template: '<h3>{{ postTitle }}</h3>'
    })
    <!-- 在 HTML 中是 kebab-case 的 -->
    <blog-post post-title="hello!"></blog-post>

    不同于组件和 prop，事件名不会被用作一个 JavaScript 变量名
    或属性名，所以就没有理由使用 camelCase 或 PascalCase 了。
    并且 v-on 事件监听器在 DOM 模板中会被自动转换为全小写
    (因为 HTML 是大小写不敏感的)，所以 v-on:myEvent 将会变成
     v-on:myevent——导致 myEvent 不可能被监听到。

#### 6. 路由包含父路径和不包含父路径
    包含父路径：  
      {
          path: "/home",
          name: "Home",
          component: Home,
          children: [{
              path: 'info',
              name: 'Info',
              component: Info
          }]
      }
      <router-link to="/home/info">one</router-link>
    不含父路径：
    {
        path: "/home",
        name: "Home",
        component: Home,
        children: [{
            path: '/info',
            name: 'Info',
            component: Info
        }]
    }
    <router-link to="/info">one</router-link>
    区别：包含父路径子路径就不需要加/，但是调用的时候需要加上父路径
