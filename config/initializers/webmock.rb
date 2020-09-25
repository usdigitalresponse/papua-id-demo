if Rails.configuration.x.truework_demo
	# Used to mock out calls to third party services in production at runtime.
	# For instance, we want to demonstrate Truework integration, but the 
	# Truework backend can take quite a while to process requests (since
	# they may need to contact employers, etc.)  To make a more compelling
	# Truework demonstration, we mock out the Truework network calls, mocking
	# responses.
	#
	# This might not be generally desirable- if this app ever becomes "real",
	# we won't want to do any mocking.  This code should all be removed or
	# at least commented out.

	require 'webmock'
	include WebMock::API
	WebMock.enable!
	WebMock.allow_net_connect!(net_http_connect_on_start: true)

	# From https://raw.githubusercontent.com/truework/truework-sdk-ruby/d2c69df3752f31a4fa0b89e6588d8f55ee94809d/spec/fixtures/report/report_1.json
	verification_1_status = {
	  "id": "report_1",
	  "state": "completed",
	  "created": "2008-09-15T15:53:00Z",
	  "type": "employment-income",
	  "price": {
	    "amount": "39.95",
	    "currency": "USD"
	  },
	  "turnaround_time": {
	    "upper_bound": "42",
	    "lower_bound": "23"
	  },
	  "permissible_purpose": "credit-application",
	  "target": {
	    "first_name": "Joe",
	    "last_name": "Smith",
	    "contact_email": "joesmith@example.org",
	    "company": {
	      "name": "Future Widget LLC"
	    }
	  },
	  "documents": [
	    {
	      "filename": "employee_authorization.pdf"
	    }
	  ]
	}

	# When they create a request for SSN 000-00-0001, we'll return "report_1", which is a success
	stub_request(:post, /api\.truework\.com\/verification-requests\/$/).with(body: hash_including("target" => hash_including("social_security_number" => "000-00-0001"))).to_return(body: verification_1_status.to_json)
	# TODO: We could add similar mocks for different SSNs, but with different results,
	# e.g. 000-00-0002 would return an "action-required" mock result.  See
	# TrueWorkIncomeValidation::addl_info.

	stub_request(:get, /api\.truework\.com\/verification-requests\/report_1\/$/).to_return(body: verification_1_status.to_json)

	# From https://raw.githubusercontent.com/truework/truework-sdk-ruby/d2c69df3752f31a4fa0b89e6588d8f55ee94809d/spec/fixtures/report/report_1.json
	report_1_response = {
	  "created":  "2008-09-15T15:53:00Z",
	  "current_as_of": "2008-09-15T15:53:00Z",
	  "verification_request": {
	    "id": "report_1",
	    "type": "employment-income",
	    "created": "2008-09-14T9:00:00Z"
	  },
	  "employer": {
	    "name": "Truework Inc",
	    "address": {
	      "line_one": "15 Lucerne Street",
	      "line_two": "Apt 2",
	      "city": "San Francisco",
	      "state": "CA",
	      "country": "US",
	      "postal_code": "94115"
	    }
	  },
	  "employee": {
	    "first_name": "First",
	    "last_name": "Last",
	    "status": "inactive",
	    "hired_date": "2017-08-08",
	    "end_of_employment": "2019-08-08",
	    "social_security_number": "***-**-9999",
	    "earnings": [
	      {
	        "year": 2019,
	        "base": "35000.00",
	        "overtime": "200.00",
	        "commission": "100.25",
	        "bonus": "500.00",
	        "total": "35800.25"
	      },
	      {
	        "year": 2018,
	        "base": "30000.00",
	        "overtime": "200.00",
	        "commission": "100.25",
	        "bonus": "500.00",
	        "total": "30800.25"
	      },
	      {
	        "year": 2017,
	        "base": "30000.00",
	        "overtime": "200.00",
	        "commission": "100.25",
	        "bonus": "500.00",
	        "total": "30800.25"
	      }
	    ],
	    "positions": [
	      {
	        "title": "current title",
	        "start_date": "2018-08-08"
	      },
	      {
	        "title": "past title",
	        "start_date": "2017-08-08",
	        "end_date": "2019-08-08"
	      }
	    ],
	    "salary": {
	      "gross_pay": "30000.00",
	      "pay_frequency": "annually",
	      "hours_per_week": "40"
	    }
	  }
	}
	stub_request(:get, /api\.truework\.com\/verification-requests\/report_1\/report\/$/).to_return(body: report_1_response.to_json)
end
