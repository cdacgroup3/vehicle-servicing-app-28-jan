package dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="car_brand_model")
public class CustomerCar {
	@Id
	@Column(name="s_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int sId;
	
	@Column(name="brand")
	private String carBrand;
	@Column(name="model")
	private String carModel;
	
	public CustomerCar() {
		super();
	}

	public CustomerCar(String carBrand, String carModel) {
		super();
		this.carBrand = carBrand;
		this.carModel = carModel;
	}

	public String getCarBrand() {
		return carBrand;
	}

	public void setCarBrand(String carBrand) {
		this.carBrand = carBrand;
	}

	public String getCarModel() {
		return carModel;
	}

	public void setCarModel(String carModel) {
		this.carModel = carModel;
	}

	@Override
	public String toString() {
		return "CustomerCar [carBrand=" + carBrand + ", carModel=" + carModel + "]";
	}
}
