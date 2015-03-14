(function(){var e;e=angular.module("SurveyTopics",["SharedServices","StartPageServices"]),e.config(["$routeProvider",function(e){return e.when("/topics",{templateUrl:"/assets/survey_topics.html",controller:"SurveyTopicsController"})}]).controller("SurveyTopicsController",["$scope","$http","$location","SharedRequests","StartPageData",function(e,t,n,r,i){var o,a;return e.MIN_NUM_TOPICS_REQUIRED=5,e.allTopics=[],e.topicSelectionModel={},o=function(){var t;return function(){var n;n=[];for(t in e.topicSelectionModel)n.push(e.topicSelectionModel[t]);return n}().reduce(function(e,t){return e+t},0)},a=function(){return Math.max(0,e.MIN_NUM_TOPICS_REQUIRED-o())},e.nextButtonValue=function(){return 0===a()?"Continue to Survey Questions":a()+" More Topic"+(1===a()?"":"s")+" to Continue"},e.disableNextButton=function(){return a()>0},e.handleTopicToggled=function(t){return e.topicSelectionModel[t]=!e.topicSelectionModel[t]},e.handleAdvanceToQuestions=function(){var t,r;i.clearSelectedTopicIds();for(t in e.topicSelectionModel)e.topicSelectionModel[t]&&i.addSelectedTopicId(t);return r=Object.keys(e.topicSelectionModel).sort(),n.path("questions/"+r[0])},r.requestTopics().success(function(t){var n,r,o,a,s,u,c,l;for(i.clearAllTopics(),n=0,a=t.length;a>n;n++)l=t[n],i.addTopic(l);for(e.allTopics=t.sort(function(e,t){return e.id-t.id}),u=i.getSelectedTopicIds(),c=[],o=0,s=u.length;s>o;o++)r=u[o],c.push(e.topicSelectionModel[r]=!0);return c})}])}).call(this);