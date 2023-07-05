<?php

namespace App\Entity;

use App\Repository\CourseRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ORM\Entity(repositoryClass=CourseRepository::class)
 */
class Course
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $name;

    /**
     * @ORM\Column(type="datetime")
     */
    private $initialDate;

    /**
     * @ORM\Column(type="datetime")
     */
    private $finalDate;

    /**
     * @ORM\ManyToMany(targetEntity=User::class, inversedBy="courses",cascade={"all"})
     */
    private $members;

    

    public function __construct()
    {
        $this->members = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

     /**
     * @return mixed
     */
    public function getInitialDate()
    {
        return $this->initialDate;
    }


      /**
     * @param mixed $initialDate
     */
    public function setInitialDate(\DateTime $initialDate): void
    {
        $this->initialDate = $initialDate;

    
    }

   /**
     * @return mixed
    */

    public function getFinalDate()
    {
        return $this->finalDate;
    }

    public function setFinalDate(\DateTime $finalDate): void
    {
        $this->finalDate = $finalDate;

       
    }

    /**
     * @return Collection<int, User>
     */
    public function getMembers(): Collection
    {
        return $this->members;
    }

    public function addMember(User $member): self
    {
        if (!$this->members->contains($member)) {
            $this->members[] = $member;
        }

        return $this;
    }

    public function removeMember(User $member): self
    {
        $this->members->removeElement($member);

        return $this;
    }

public function __toString()
{
    return $this->name;
}

}
