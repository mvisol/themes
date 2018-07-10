// var masterapp= angular.module('masterapp',['xml']);
  
var masterApp= angular.module('masterApp',[]);

   masterApp.provider('master',['appdetails', function(appdetails) {
   
      // Through below method only we access makeurl in .config of any app 
      
      this.makeurl = function(getLoc) {
         return "./myResource?"+ appdetails.model.instance[2].data.currentSolutionContext+"/"+ appdetails.model.instance[0].data.appId+"/"+getLoc;
      };
      
      
      // Below is like factory. We can define 'n' number of functions or variables and those can be access in any other controllers, factories, services
      
      this.$get = function(appdetails)
      {
            return {
               makeurl: function(getLoc) {
                  return "./myResource?"+ appdetails.model.instance[2].data.currentSolutionContext+"/"+ appdetails.model.instance[0].data.appId+"/"+getLoc;
               }
            }
      }
             
}]);

    var xmlApp= angular.module('xmlApp',['xml']);
    
    xmlApp.config(function ($httpProvider) {
    $httpProvider.interceptors.push('xmlHttpInterceptor');
  });                 
  
  $('[data-toggle="offcanvas"]').click(function () {
                $('.row-offcanvas').toggleClass('active')
            });
        