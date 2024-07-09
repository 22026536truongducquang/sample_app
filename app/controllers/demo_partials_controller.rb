class DemoPartialsController < ApplicationController
  def new
    @zone = t("demo_partials.form.zone_label")
    @date = Time.zone.today
  end

  def edit
    @zone = t("demo_partials.form.zone_label")
    @date = Time.zone.today - 4
  end
end
