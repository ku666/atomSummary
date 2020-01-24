#### 1、vue中组件通信的有哪些方式，请简单描述一下每种方式的使用
+ 1.父子组件通信
      分两种情况，父向子传递，通过props，子向父传递通过$emit和事件触发
+ 2.非父子组件之间的通信
      使用eventBus这种通信方式,针对的是非父子组件之间的通信,它的原理还是通过事件的触发和监听。但是因为是非父子组件的关系,他们需要有一个中间组件来连接。
通过在根组件或者再声明一个组件,通过再看#app组件上定义了一个所有组件都可以访问到的组件,具体使用方式如下：

      使用eventBus传递数据,我们一共需要做3件事情

      1.给app组件添加Bus属性 (这样所有组件都可以通过this.$root.Bus访问到它,而且不需要引入任何文件)
      2.在组件1里,this.$root.Bus.$emit触发事件
      3.在组件2里,this.$root.Bus.$on监听事件

      // 1.在main.js里给app组件,添加bus属性
      import Vue from 'vue'
      new Vue({
        el: '#app',
        components: { App },
        template: '<App/>',
        data(){
          return {
            Bus : new Vue()
          }
        }
      })

    // 2.在组件1里,触发emit
    increment(){
     this.number++
     this.$root.Bus.$emit('eventName', this.number)
     },

    // 3.在组件2里,监听事件,接受数据
    mounted(){
     this.$root.Bus.$on('eventName', value => {
     this.number = value
     console.log('busEvent');
     })
   }

+  3. 利用seesionStorage和localStorage来通信

    这种通信比较简单,缺点是数据和状态比较混乱,不太容易维护。
    通过window.localStorage.getItem(key) 获取数据
    通过window.localStorage.setItem(key,value) 存储数据
    注意：用JSON.parse() / JSON.stringify() 做数据格式转换。

+  4.  利用Vuex版本控制工具

        import { Message } from 'element-ui';
        import { setCookies, removeCookies, getCookies } from '@/utils/auth';

        import api from '@/api/common';

        const common = {
        namespaced: true,
        state: {
        token: ''
        },
        mutations: {
          GET_HEADER(state, data) {
            state.header = data;
          },
          SET_TOKEN(state, val) {
            state.token = val;
          },
        message(state, args) {
          if (
            !args ||
            args === '000' ||
            (typeof args === 'object' && !args.message)
          ) {
            return false;
          }
          Message(args);
        }
        },
        actions: {
            async getCookies(store, val) {
              let result = await getCookies(val);
              return result;
            },
            async setCookies(store, { key, data }) {
              let result = await setCookies(key, data);
              return result;
            },
            async removeCookies(store, val) {
              let result = await removeCookies(val);
              return result;
            },
            async getLovString(store, params) {
              let result = await api.getLovString(params);
              return result;
            },
            async Get_Login(store, params) {
              let data = await api.getLogin(params);
              return data;
            },
            async getMenu(store, params) {
              let data = await api.getMenu(params);
              return data;
            },
            async getWorkflowUrl(store, params) {
              let data = await api.getWorkflowUrl(params);
              return data;
            }
            }
        };

        export default common;

        调用： this.$store.dispatch('customer/Get_Customer_list',args);

#### 2、实现双向绑定主要有哪几种做法，Vue是采用的是哪种
