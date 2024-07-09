class DemoPartialsController < ApplicationController
  def new
<<<<<<< HEAD
    @zone = t("demo_partials.form.zone_label")
=======
    @zone = "Zone new action"
>>>>>>> 3d7a312 (Update pull_request_template.md)
    @date = Time.zone.today
  end

  def edit
<<<<<<< HEAD
    @zone = t("demo_partials.form.zone_label")
=======
    @zone = "Zone edit action"
>>>>>>> 3d7a312 (Update pull_request_template.md)
    @date = Time.zone.today - 4
  end
end
