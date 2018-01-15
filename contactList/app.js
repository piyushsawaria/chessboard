angular.module('contact', [])
.controller('Contact', 
function($scope, $http) {
  $http.get('api.json').
    then(function(response) {
      $scope.contactList = response.data;
    });
  $scope.addcontact = function(){
		$scope.contactList.contacts.push({
			type: $scope.type, 
			name: $scope.name,
			title: $scope.title,
			phone: $scope.phone,
			ext: $scope.ext,
			fax: $scope.fax,
			email: $scope.email
		});
	};
});